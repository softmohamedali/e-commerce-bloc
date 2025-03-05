import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../../core/app/app.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../core/utils/configs.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constant/colors.dart';
import '../../../core/app/app_router.dart';
import '../../domain/entites/category.dart';
import 'loading_shimmer.dart';

class SquareProductItem extends StatelessWidget {
  const SquareProductItem({super.key, this.product});

  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return product != null
        ? Padding(
            padding: EdgeInsets.only(right: AppDimensions.normalize(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context)
                        .pushNamed(AppRouter.productDetails, arguments: product);
                  },
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Hero(
                      tag:product!.id ,
                      child: CachedNetworkImage(
                        height: AppDimensions.normalize(70),
                        width: AppDimensions.normalize(70),
                        imageUrl: product!.images.last,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => placeholderShimmer(),
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                      ),
                    ),
                  ),
                ),
                Space.y1!,
                SizedBox(
                  width: AppDimensions.normalize(60),
                  child: Text(
                    product!.title.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.b2b?.copyWith(color: AppColors.GreyText),
                  ),
                )
              ],
            ),
          )
        : LoadingShimmer(isSquare: true);
  }
}
