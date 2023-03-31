import 'package:flutter/material.dart';
import 'package:shoesappclient/models/brand_model.dart';
import 'package:shoesappclient/services/remote/firestore_service.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/ui/widgets/item_brand_widget.dart';

class BrandPage extends StatelessWidget {
  FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: firestoreService.getBrands(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            List<BrandModel> brands = snap.data;

            return CustomScrollView(
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
                    children: brands
                        .map(
                          (e) => ItemBrandWidget(brand: e),
                        )
                        .toList(),
                    // [
                    //   ItemBrandWidget(),
                    //   ItemBrandWidget(),
                    //   ItemBrandWidget(),
                    //   ItemBrandWidget(),
                    //   ItemBrandWidget(),
                    //   ItemBrandWidget(),
                    //   ItemBrandWidget(),
                    // ],
                  ),
                ),
              ],
            );
          }
          return loadingWidget;
        },
      ),
    );
  }
}
