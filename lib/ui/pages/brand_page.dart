import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/ui/widgets/item_brand_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';

class BrandPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: GridView.count(
      //   crossAxisCount: 2,
      //   childAspectRatio: 1.40,
      //   children: [
      //     ItemBrandWidget(),
      //     ItemBrandWidget(),
      //     ItemBrandWidget(),
      //     ItemBrandWidget(),
      //     ItemBrandWidget(),
      //     ItemBrandWidget(),
      //   ],
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            title: H5(
              text: "Nuestras Marcas",
              fontWeight: FontWeight.w700,
            ),
            toolbarHeight: 80.0,
            centerTitle: true,
          ),
          SliverPadding(
            padding: EdgeInsets.all(14.0),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 7,
              mainAxisSpacing: 10,
              children: [
                ItemBrandWidget(),
                ItemBrandWidget(),
                ItemBrandWidget(),
                ItemBrandWidget(),
                ItemBrandWidget(),
                ItemBrandWidget(),
                ItemBrandWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
