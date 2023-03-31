import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoesappclient/models/product_model.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/pages/product_detail_page.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';
import 'package:shoesappclient/utils/calculate.dart';

class ItemSearchWidget extends StatelessWidget {
  ProductModel product;

  ItemSearchWidget({required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 8.0,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: BrandColor.primaryFontColor.withOpacity(0.09),
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                imageUrl: product.image,
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
            spacing12Width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  H6(
                    text: product.brand,
                    color: BrandColor.primaryFontColor.withOpacity(0.55),
                  ),
                  spacing2,
                  H5(
                    text: product.name,
                    height: 1.1,
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  spacing4Width,
                  Row(
                    children: [
                      H5(
                        text:
                            "S/ ${Calculate.getPrice(product.price, product.discount).toStringAsFixed(2)}",
                        fontWeight: FontWeight.w700,
                      ),
                      spacing8Width,
                      product.discount > 0
                          ? H6(
                              text: "S/ ${product.price.toStringAsFixed(2)}",
                              color:
                                  BrandColor.primaryFontColor.withOpacity(0.55),
                              textDecoration: TextDecoration.lineThrough,
                            )
                          : SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
