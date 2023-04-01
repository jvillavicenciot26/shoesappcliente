import 'package:flutter/material.dart';
import 'package:shoesappclient/models/brand_model.dart';
import 'package:shoesappclient/models/product_model.dart';
import 'package:shoesappclient/services/remote/firestore_service.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/ui/widgets/item_products_widget.dart';

class BrandFilterPage extends StatelessWidget {
  BrandModel model;
  BrandFilterPage({required this.model});
  FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: firestoreService.getProducts(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            List<ProductModel> products = snap.data;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  floating: true,
                  title: H5(
                    text: model.name,
                    fontWeight: FontWeight.w700,
                  ),
                  toolbarHeight: 50,
                  centerTitle: true,
                ),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 6.0,
                    crossAxisSpacing: 6.0,
                    childAspectRatio: 0.9,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ItemProductsWidget(
                        model: products[index],
                      );
                      //return Text("Hola");
                    },
                    childCount: products.length,
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
