import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoesappclient/models/product_model.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/ui/widgets/item_discount_widet.dart';
import 'package:shoesappclient/utils/asset_data.dart';
import 'package:shoesappclient/utils/responsive.dart';

class ItemOfferWidget extends StatelessWidget {
  ProductModel model;

  ItemOfferWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    double price = model.price;
    if (model.discount > 0) {
      price = price - (model.price * model.discount / 100);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      margin: const EdgeInsets.only(right: 12.0),
      width: ResponsiveUI.pDiagonal(context, 0.33),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    H6(
                      text: model.brand,
                      color: BrandColor.primaryFontColor.withOpacity(0.55),
                    ),
                    spacing2,
                    H5(
                      text: model.name,
                      height: 1.1,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    spacing4,
                    H5(
                      text: "S/ ${price.toStringAsFixed(2)}",
                      color: BrandColor.primaryFontColor,
                      fontWeight: FontWeight.w700,
                    )
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: CachedNetworkImage(
                  imageUrl: model.image,
                  height: 90.0,
                  width: 105.0,
                  fit: BoxFit.cover,
                  errorWidget: ((context, url, error) {
                    return Image.asset(
                      AssetData.imagePlaceHolder,
                    );
                  }),
                  progressIndicatorBuilder: (context, url, progress) {
                    return loadingWidget;
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: 5,
            right: 3,
            child: ItemDiscountWidget(discount: 10),
          ),
        ],
      ),
    );
  }
}
