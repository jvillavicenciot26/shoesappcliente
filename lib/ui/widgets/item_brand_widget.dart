import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoesappclient/models/brand_model.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';

class ItemBrandWidget extends StatelessWidget {
  BrandModel brand;
  VoidCallback onTap;

  ItemBrandWidget({
    required this.brand,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        //margin: EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: CachedNetworkImage(
            imageUrl: brand.image,
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
      ),
    );
  }
}
