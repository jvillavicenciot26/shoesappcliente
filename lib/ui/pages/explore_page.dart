import 'package:flutter/material.dart';
import 'package:shoesappclient/models/product_model.dart';
import 'package:shoesappclient/services/remote/firestore_service.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/ui/widgets/item_products_widget.dart';

class ExplorePage extends StatelessWidget {
  FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    firestoreService.getProducts();
    return Scaffold(
      body: FutureBuilder(
        future: firestoreService.getProducts(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            List<ProductModel> products = snap.data;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: BrandColor.primaryColor,
                  floating: true,
                  pinned: false,
                  centerTitle: true,
                  titleSpacing: 16.0,
                  //collapsedHeight: 70.0,
                  toolbarHeight: 90.0,
                  shadowColor: BrandColor.primaryColor,
                  title: TextField(
                    cursorColor: BrandColor.secondaryFontColor,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: BrandColor.secondaryFontColor,
                    ),
                    // enabled: false,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Buscar producto...",
                      hintStyle: const TextStyle(
                        fontSize: 14.0,
                        color: BrandColor.secondaryFontColor,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.35),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 18.0,
                        color: BrandColor.secondaryFontColor,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 12.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 14.0,
                        ),
                        child: H5(
                          text: "Nuestro Productos",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 6.0,
                    crossAxisSpacing: 6.0,
                    childAspectRatio: 0.9,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    childCount: products.length,
                    (BuildContext context, int index) {
                      return ItemProductsWidget(
                        model: products[index],
                      );
                      //return Text("Hola");
                    },
                  ),
                )
              ],
            );
          }
          return loadingWidget;
        },
      ),
    );
  }
}
