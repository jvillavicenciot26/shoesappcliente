import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoesappclient/models/brand_model.dart';
import 'package:shoesappclient/models/product_model.dart';

class FirestoreService {
  Future<List<ProductModel>> getProducts() async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("products");

    QuerySnapshot collection = await reference.get();
    //print(collection.size);
    List<QueryDocumentSnapshot> docs = collection.docs;
    List<ProductModel> products = [];

    List<BrandModel> brands = await getBrands();

    // products = docs
    //     .map((e) => ProductModel.fromJson(e.data() as Map<String, dynamic>))
    //     .toList(); // igual a linea 18

    for (QueryDocumentSnapshot item in docs) {
      ProductModel product =
          ProductModel.fromJson(item.data() as Map<String, dynamic>);
      String newBrand =
          brands.where((element) => element.id == product.brand).first.name;
      product.brand = newBrand;
      products.add(product);
    }
    return products;
  }

  Future<List<BrandModel>> getBrands() async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("brands");
    QuerySnapshot collection = await reference.get();
    List<QueryDocumentSnapshot> docs = collection.docs;
    List<BrandModel> brands = [];

    // brands = docs
    //     .map((e) => BrandModel.fromJson(e.data() as Map<String, dynamic>))
    //     .toList();

    for (QueryDocumentSnapshot item in docs) {
      BrandModel brand =
          BrandModel.fromJson(item.data() as Map<String, dynamic>);
      brand.id = item.id;
      brands.add(brand);
    }

    return brands;
  }
}
