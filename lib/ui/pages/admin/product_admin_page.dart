import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoesappclient/models/product_model.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/pages/admin/product_form_admin_page.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';

class ProductAdminPage extends StatelessWidget {
  CollectionReference productReference =
      FirebaseFirestore.instance.collection("products");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BrandColor.secondaryColor,
        title: H4(
          text: "Productos",
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductFormAdminPage(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: BrandColor.secondaryColor,
      ),
      body: StreamBuilder(
        stream: productReference.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            QuerySnapshot collection = snap.data;
            List<QueryDocumentSnapshot> docs = collection.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data =
                    docs[index].data() as Map<String, dynamic>;
                ProductModel product = ProductModel.fromJson(data);
                return ListTile(
                  leading: ClipRRect(
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
                  title: H5(
                    text: product.name,
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: BrandColor.primaryFontColor.withOpacity(0.4),
                  ),
                );
              },
            );
          }
          return loadingWidget;
        },
      ),
    );
  }
}
