import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/models/product_model.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../core/utils/configs.dart';
import '../../../core/constant/assets.dart';

import '../../../core/constant/colors.dart';
import '../../../core/app/app_router.dart';
import 'loading_shimmer.dart';

class RectangularProductItem extends StatelessWidget {
  final ProductModel? product;
  final Function? onClick;
  final bool isFromWishlist;

  const RectangularProductItem({
    Key? key,
    this.product,
    this.onClick,
    this.isFromWishlist = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return product == null
        ? LoadingShimmer(isSquare: true)
        : buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppRouter.productDetails, arguments: product);
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.only(bottom: AppDimensions.normalize(10.8)),
        child: Padding(
          padding: isFromWishlist ? Space.all(.5, .5) : Space.all(1, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              product!.images.isNotEmpty
                  ? CachedNetworkImage(
                      height: AppDimensions.normalize(70),
                      imageUrl: isFromWishlist
                          ? product!.images.last
                          : product!.images.first,
                      placeholder: (context, url) => placeholderShimmer(),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    )
                  : Image.asset(
                      AppAssets.Logo,
                      height: AppDimensions.normalize(70),
                    ),
              Space.y1!,
              Text(
                product!.title,
                style: AppText.h3b,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Space.y!,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    r'$ ' + product!.price.toString(),
                    style: AppText.h3?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        product!.rating.toString(),
                        style: AppText.b2?.copyWith(
                          color: AppColors.coralPink,
                        ),
                      ),
                      Icon(
                        Icons.star,
                        color: AppColors.coralPink,
                        size: 20,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
