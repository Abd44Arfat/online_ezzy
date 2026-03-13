import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ezzy/Features/Products/cubit/products_cubit.dart';
import 'package:online_ezzy/Features/Products/cubit/products_state.dart';
import 'package:online_ezzy/Features/Products/product_details_view.dart';
import 'package:online_ezzy/core/utils/networking/dio_helper.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';
import 'package:online_ezzy/data/Models/products/product_model.dart';
import 'package:online_ezzy/repo/product_repo.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsCubit(ProductRepository(DioClient()))
        ..loadProducts(perPage: 50, page: 1),
      child: Scaffold(
        backgroundColor: AppColors.greyLight,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          title: Text('المنتجات', style: AppStyles.styleSemiBold16(context)),
          centerTitle: true,
        ),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductsFailure) {
              return Center(child: Text(state.message));
            }
            if (state is ProductsSuccess) {
              final items = state.products;
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final p = items[index];
                  return _ProductGridCard(
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
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _ProductGridCard extends StatelessWidget {
  const _ProductGridCard({required this.product, required this.onTap});
  final ProductModel product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
                      : Image.network(
                          product.primaryImage!,
                          fit: BoxFit.cover,
                        ),
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

