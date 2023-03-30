import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoesappclient/models/product_model.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/ui/widgets/item_discount_widet.dart';
import 'package:shoesappclient/ui/widgets/item_size_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';
import 'package:shoesappclient/utils/calculate.dart';
import 'package:shoesappclient/utils/responsive.dart';

class ProductDetailPage extends StatelessWidget {
  ProductModel product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: product.image,
                height: ResponsiveUI.pDiagonal(context, 0.37),
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return Image.asset(AssetData.imagePlaceHolder);
                },
                progressIndicatorBuilder: (context, url, progress) {
                  return loadingWidget;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ItemDiscountWidget(discount: 40),
                    spacing8,
                    H4(
                      text: product.brand,
                      color: BrandColor.primaryFontColor.withOpacity(0.60),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: H2(
                            text: product.name,
                            fontWeight: FontWeight.w900,
                            height: 1,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            product.discount > 0
                                ? H6(
                                    text:
                                        "S/ ${product.price.toStringAsFixed(2)}",
                                    color: BrandColor.primaryFontColor
                                        .withOpacity(0.60),
                                    textDecoration: TextDecoration.lineThrough,
                                  )
                                : SizedBox(),
                            spacing4,
                            H4(
                              text:
                                  "S/ ${Calculate.getPrice(product.price, product.discount).toStringAsFixed(2)}",
                              fontWeight: FontWeight.w900,
                              height: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                    spacing16,
                    H5(
                      text: "Tallas Disponibles",
                      color: BrandColor.primaryFontColor.withOpacity(0.60),
                    ),
                    spacing12,
                    Wrap(
                      spacing: 8,
                      runSpacing: 10,
                      children: product.sizes
                          .map((e) => ItemSizeWidget(size: e))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              height: 100,
              //color: Colors.amber,
              child: Row(
                children: [
                  H2(
                    text:
                        "S/ ${Calculate.getPrice(product.price, product.discount).toStringAsFixed(2)}",
                  ),
                  spacing14Width,
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BrandColor.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        icon: SvgPicture.asset(
                          AssetData.iconWhatsapp,
                          color: Colors.white,
                        ),
                        label: H4(
                          text: "Obtener ahora",
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
