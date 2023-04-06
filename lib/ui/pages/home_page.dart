import 'package:flutter/material.dart';
import 'package:shoesappclient/models/product_model.dart';
import 'package:shoesappclient/services/local/sp_global.dart';
import 'package:shoesappclient/services/remote/firestore_service.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/ui/widgets/item_offer_widget.dart';
import 'package:shoesappclient/ui/widgets/item_products_widget.dart';

class HomePage extends StatelessWidget {
  // CollectionReference productReference =
  //     FirebaseFirestore.instance.collection("products");

  FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    firestoreService.getProducts();
    // productReference.get().then(
    //   (value) {
    //     print(
    //       value.docs.length,
    //     );
    //   },
    // );

    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: firestoreService.getProducts(),
          // Future.wait(
          //   // [
          //   //   firestoreService.getProducts(),
          //   //   firestoreService.getBrands(),
          //   // ],
          // ),
          builder: (BuildContext context, AsyncSnapshot snap) {
            //print(snap.hasData);
            if (snap.hasData) {
              List<ProductModel> products = snap.data; //[0];
              //List<BrandModel> brands = snap.data[1];
              //print(snap.data[1]);
              List<ProductModel> productsDiscount = [];

              // los 3 bloques siguientes hacen lo mismo
              // for (var item in products) {
              //   if (item.discount > 0) {
              //     productsDiscount.add(item);
              //   }
              // }

              // products.forEach(
              //   (element) {
              //     if (element.discount > 0) {
              //       productsDiscount.add(element);
              //     }
              //   },
              // );

              productsDiscount = products.where((e) => e.discount > 0).toList();

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.0),
                      color: BrandColor.primaryColor,
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            spacing30,
                            H1(
                              text:
                                  "Hola, ${SPGlobal().fullName}, bienvenido nuevamente.",
                              //"Hola José Daniel Diaz, bienvenido nuevamente.",
                              height: 1.15,
                            ),
                            spacing8,
                            H5(
                              text: "Tenemos las mejores ofertas",
                            ),
                            spacing12,
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              child: Row(
                                children: productsDiscount.map(
                                  (e) {
                                    // String idBrand = e.brand;
                                    // String newBrand = brands
                                    //     .where(
                                    //         (element) => element.id == idBrand)
                                    //     .first
                                    //     .name;
                                    // e.brand = newBrand;
                                    return ItemOfferWidget(
                                      model: e,
                                    );
                                  },
                                ).toList(),
                                // [
                                //   ItemOfferWidget(),
                                //   ItemOfferWidget(),
                                //   ItemOfferWidget(),
                                // ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          H5(
                            text: "Últimos ingresos",
                            fontWeight: FontWeight.w700,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: BrandColor.primaryColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Row(
                              children: [
                                H6(
                                  text: "Ver Todo",
                                  color: BrandColor.secondaryFontColor,
                                ),
                                const Icon(
                                  Icons.arrow_right,
                                  color: BrandColor.secondaryFontColor,
                                  size: 16.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 6.0,
                        crossAxisSpacing: 6.0,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        // String idBrand = products[index].brand;

                        // String newBrand = brands
                        //     .where((element) => element.id == idBrand)
                        //     .first
                        //     .name;

                        // products[index].brand = newBrand;

                        return ItemProductsWidget(
                          model: products[index],
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: loadingWidget,
            );
          },
        ));
  }
}
