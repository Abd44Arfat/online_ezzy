import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ezzy/Features/Cart/cubit/cart_cubit.dart';
import 'package:online_ezzy/core/utils/networking/dio_helper.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';
import 'package:online_ezzy/data/Models/products/product_model.dart';
import 'package:online_ezzy/data/Models/products/variation_model.dart';
import 'package:online_ezzy/repo/product_repo.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  List<ProductVariationModel> _variations = const [];
  int? _selectedVariationId;
  bool _loadingVars = false;
  String? _variationError;

  String _stripHtml(String input) {
    return input
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll(RegExp(r'\\s+'), ' ')
        .trim();
  }

  @override
  void initState() {
    super.initState();
    if (widget.product.type == 'variable') {
      _loadVariations();
    }
  }

  Future<void> _loadVariations() async {
    setState(() {
      _loadingVars = true;
      _variationError = null;
    });
    try {
      final repo = ProductRepository(DioClient());
      final vars = await repo.fetchVariations(widget.product.id);
      // Prefer purchasable + in stock first
      final preferred = vars
          .where((v) => v.purchasable && v.inStock)
          .toList(growable: false);
      setState(() {
        _variations = vars;
        _selectedVariationId =
            (preferred.isNotEmpty ? preferred.first.id : (vars.isNotEmpty ? vars.first.id : null));
        _loadingVars = false;
      });
    } catch (e) {
      setState(() {
        _loadingVars = false;
        _variationError = e.toString();
      });
    }
  }

  Map<String, String>? _buildStoreVariationAttributes(
    ProductVariationModel variation,
  ) {
    final productAttrs = widget.product.attributes;
    if (variation.attributes.isEmpty) return null;

    final Map<String, String> result = {};

    for (final vAttr in variation.attributes) {
      ProductAttribute? baseAttr;
      for (final pAttr in productAttrs) {
        final vName = vAttr.name.toLowerCase();
        if (pAttr.name.toLowerCase() == vName ||
            pAttr.slug.toLowerCase() == vName) {
          baseAttr = pAttr;
          break;
        }
      }

      // WooCommerce Store API expects:
      // - taxonomy attribute: attribute_pa_{slug}
      // - custom attribute:   attribute_{slug}
      String slug;
      String keyPrefix = 'attribute_';

      if (baseAttr != null && baseAttr.slug.isNotEmpty) {
        slug = baseAttr.slug;
        if (baseAttr.id != 0) {
          // Global attribute (taxonomy) -> add "pa_" prefix
          keyPrefix = 'attribute_pa_';
        }
      } else {
        slug = vAttr.name.toLowerCase().replaceAll(' ', '-');
      }

      final key = '$keyPrefix$slug';
      result[key] = vAttr.option;
    }

    return result.isEmpty ? null : result;
  }

  String _variationLabel(ProductVariationModel v) {
    if (v.attributes.isEmpty) return 'Variation #${v.id}';
    return v.attributes.map((a) => '${a.name}: ${a.option}').join(' • ');
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final cleanDesc = _stripHtml(product.description);
    return Scaffold(
      backgroundColor: AppColors.greyLight,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text('تفاصيل المنتج', style: AppStyles.styleSemiBold16(context)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: AppColors.white,
                  child: product.primaryImage == null
                      ? const Icon(Icons.image_not_supported_outlined)
                      : Image.network(product.primaryImage!, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(product.name, style: AppStyles.styleSemiBold16(context)),
            const SizedBox(height: 8),
            Text(
              '\$${product.price}',
              style: AppStyles.styleBold16(context).copyWith(
                color: AppColors.mainColor,
              ),
            ),
            const SizedBox(height: 12),
            if (product.type == 'variable') ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('اختر النوع', style: AppStyles.styleSemiBold14(context)),
                    const SizedBox(height: 8),
                    if (_loadingVars)
                      const Center(child: CircularProgressIndicator())
                    else if (_variationError != null)
                      Text(
                        _variationError!,
                        style: AppStyles.styleRegular12(context).copyWith(
                          color: AppColors.mainColor,
                        ),
                      )
                    else if (_variations.isEmpty)
                      Text(
                        'لا توجد أنواع متاحة لهذا المنتج',
                        style: AppStyles.styleRegular12(context).copyWith(
                          color: AppColors.greyDark,
                        ),
                      )
                    else
                      DropdownButtonFormField<int>(
                        isExpanded: true,
                        value: _selectedVariationId,
                        items: _variations
                            .map(
                              (v) => DropdownMenuItem(
                                value: v.id,
                                child: Text(
                                  _variationLabel(v),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => _selectedVariationId = v),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.greyLight,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  cleanDesc.isEmpty ? 'لا يوجد وصف' : cleanDesc,
                  style: AppStyles.styleRegular14(context).copyWith(
                    color: AppColors.greyDark,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: () async {
                  Map<String, String>? variationMap;
                  if (product.type == 'variable') {
                    final variationId = _selectedVariationId;
                    if (variationId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('اختر نوع المنتج أولاً')),
                      );
                      return;
                    }

                    ProductVariationModel? selected;
                    for (final v in _variations) {
                      if (v.id == variationId) {
                        selected = v;
                        break;
                      }
                    }

                    if (selected == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('حدث خطأ في اختيار النوع')),
                      );
                      return;
                    }

                    variationMap = _buildStoreVariationAttributes(selected);
                  }

                  await context
                      .read<CartCubit>()
                      .addItem(product.id, 1, variation: variationMap);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تمت الإضافة إلى السلة')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'إضافة إلى السلة',
                  style: AppStyles.styleSemiBold16(context).copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

