import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';

class ItemBrandWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: CachedNetworkImage(
          imageUrl:
              "https://cooljsonline.com/wp-content/uploads/2020/05/shop-adidas-banner.jpg",
          errorWidget: (context, url, error) {
            return Image.asset(
              AssetData.imagePlaceHolder,
            );
          },
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, progress) {
            return loadingWidget;
          },
        ),
      ),
    );
  }
}
