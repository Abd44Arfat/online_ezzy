import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ezzy/Features/Products/cubit/products_cubit.dart';
import 'package:online_ezzy/Features/Products/cubit/products_state.dart';
import 'package:online_ezzy/Features/Products/product_details_view.dart';
import 'package:online_ezzy/Features/Products/products_grid_view.dart';
import 'package:online_ezzy/core/utils/networking/dio_helper.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';
import 'package:online_ezzy/data/Models/products/product_model.dart';
import 'package:online_ezzy/repo/product_repo.dart';

class HomeProductsPreviewSection extends StatelessWidget {
  const HomeProductsPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsCubit(ProductRepository(DioClient()))
        ..loadProducts(perPage: 4, page: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المنتجات',
                style: AppStyles.styleBold14(context),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ProductsGridView()),
                  );
                },
                child: Text(
                  'عرض الكل',
                  style: AppStyles.styleRegular12(context).copyWith(
                    color: AppColors.mainColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 210,
            child: BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ProductsFailure) {
                  return Center(child: Text(state.message));
                }
                if (state is ProductsSuccess) {
                  final items = state.products;
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final p = items[index];
                      return _PreviewCard(
                        product: p,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ProductDetailsView(product: p),
                            ),
                          );
                        },
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemCount: items.length,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard({required this.product, required this.onTap});
  final ProductModel product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  color: AppColors.greyLight,
                  child: product.primaryImage == null
                      ? const Icon(Icons.image_not_supported_outlined)
                      : Image.network(product.primaryImage!, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.styleSemiBold12(context),
            ),
            const SizedBox(height: 6),
            Text(
              '\$${product.price}',
              style: AppStyles.styleSemiBold14(context).copyWith(
                color: AppColors.mainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

