import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:shoesappclient/models/brand_model.dart';
import 'package:shoesappclient/models/product_model.dart';
import 'package:shoesappclient/services/remote/firestore_service.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/widgets/common_button_widget.dart';
import 'package:shoesappclient/ui/widgets/common_input_widget.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';
import 'package:shoesappclient/utils/responsive.dart';
import 'package:shoesappclient/utils/types.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProductFormAdminPage extends StatefulWidget {
  ProductModel? productModel;
  ProductFormAdminPage({this.productModel});
  @override
  State<ProductFormAdminPage> createState() => _ProductFormAdminPageState();
}

class _ProductFormAdminPageState extends State<ProductFormAdminPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();

  List<double> sizes = [];
  List<BrandModel> brands = [];
  String idBrand = "";

  ImagePicker imagePicker = ImagePicker();
  XFile? image;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    isLoading = true;
    setState(() {});
    FirestoreService firestoreService = FirestoreService();
    brands = await firestoreService.getBrands();
    idBrand = brands.first.id!;

    if (widget.productModel != null) {
      nameController.text = widget.productModel!.name;
      priceController.text = widget.productModel!.price.toStringAsFixed(2);
      discountController.text = widget.productModel!.discount.toString();
      stockController.text = widget.productModel!.stock.toString();
      sizes = widget.productModel!.sizes;
      idBrand = widget.productModel!.brand;
    }
    isLoading = false;
    setState(() {});
  }

  Future<void> getImageGallery() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {});
    }
  }

  Future<String> uploadImageStorage() async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;

    firebase_storage.Reference referenceStorage =
        storage.ref().child("examples");

    String name = DateTime.now().toString();

    String temp = mime(image!.path) ?? "";

    String extension = temp.split("/")[1];

    firebase_storage.TaskSnapshot uploadTask = await referenceStorage
        .child("$name.$extension")
        .putFile(File(image!.path));

    return await uploadTask.ref.getDownloadURL();
  }

  registerProduct() async {
    FirestoreService firestoreService = FirestoreService();
    String urlImage = await uploadImageStorage();
    ProductModel product = ProductModel(
      name: nameController.text,
      price: double.parse(priceController.text),
      image: urlImage,
      discount: int.parse(discountController.text),
      status: true,
      stock: int.parse(stockController.text),
      brand: idBrand,
      sizes: sizes,
    );
    String id = await firestoreService.registerProduct(product);
    if (id.isNotEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  updateProduct() async {
    FirestoreService firestoreService = FirestoreService();

    ProductModel product = ProductModel(
      id: widget.productModel!.id,
      name: nameController.text,
      price: double.parse(priceController.text),
      image: "",
      discount: int.parse(discountController.text),
      status: true,
      stock: int.parse(stockController.text),
      brand: idBrand,
      sizes: sizes,
    );

    if (image != null) {
      String urlImage = await uploadImageStorage();
      product.image = urlImage;
    } else {
      product.image = widget.productModel!.image;
    }

    await firestoreService.updateProduct(product);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // sizes = sizes.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: BrandColor.secondaryColor,
        title: H4(
          text: widget.productModel != null
              ? "Actualizar Producto"
              : "Agregar Producto",
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonInputWidget(
                    label: "Nombre del producto",
                    hintText: "Nombre del producto",
                    icon: AssetData.iconRocket,
                    controller: nameController,
                    inputType: InputTypeEnum.text,
                  ),
                  spacing20,
                  H5(
                    text: "  Marca:",
                    fontWeight: FontWeight.w500,
                  ),
                  spacing8,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(4, 4),
                        ),
                      ],
                    ),
                    child: DropdownButton(
                      value: idBrand,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(20.0),
                      elevation: 6,
                      underline: const SizedBox(),
                      items: brands
                          .map(
                            (e) => DropdownMenuItem(
                              child: H5(text: e.name),
                              value: e.id,
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        idBrand = value!;
                        setState(() {});
                      },
                    ),
                  ),
                  spacing20,
                  Row(
                    children: [
                      Expanded(
                        child: CommonInputWidget(
                          label: "Precio (S/.)",
                          hintText: "Precio",
                          icon: AssetData.iconRocket,
                          controller: priceController,
                          inputType: InputTypeEnum.text,
                        ),
                      ),
                      spacing16Width,
                      Expanded(
                        child: CommonInputWidget(
                          label: "Descuento (%)",
                          hintText: "Descuento",
                          icon: AssetData.iconRocket,
                          controller: discountController,
                          inputType: InputTypeEnum.text,
                        ),
                      ),
                    ],
                  ),
                  spacing20,
                  Row(
                    children: [
                      Expanded(
                        child: CommonInputWidget(
                          label: "Stock",
                          hintText: "Stock",
                          icon: AssetData.iconRocket,
                          controller: stockController,
                          inputType: InputTypeEnum.text,
                        ),
                      ),
                      spacing16Width,
                      const Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                  spacing20,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: CommonInputWidget(
                          label: "Tallas",
                          hintText: "Talla",
                          icon: AssetData.iconRocket,
                          controller: sizeController,
                          inputType: InputTypeEnum.text,
                        ),
                      ),
                      spacing16Width,
                      InkWell(
                        onTap: () {
                          double size = double.parse(sizeController.text);
                          sizes.add(size);
                          sizeController.clear();
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: BrandColor.primaryFontColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  spacing16,
                  Container(
                    height: ResponsiveUI.pDiagonal(context, 0.25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(4, 4),
                        ),
                      ],
                    ),
                    child: sizes.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: sizes.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: H5(
                                    text:
                                        "Talla: ${sizes[sizes.length - index - 1]}"),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete_rounded,
                                    size: 20.0,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () {
                                    sizes.removeAt(sizes.length - index - 1);
                                    setState(() {});
                                  },
                                ),
                              );
                            },
                          )
                        : Center(
                            child: H5(text: "Aún no hay tallas agregadas.")),
                  ),
                  spacing30,
                  CommonButtonWidget(
                    color: BrandColor.primaryFontColor,
                    text: "Galería",
                    icon: AssetData.iconRocket,
                    onPressed: () {
                      getImageGallery();
                    },
                  ),
                  spacing20,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14.0),
                    child: Image(
                      image: image != null
                          ? FileImage(File(image!.path))
                          : widget.productModel != null
                              ? NetworkImage(widget.productModel!.image)
                              : const AssetImage(AssetData.imagePlaceHolder)
                                  as ImageProvider,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: ResponsiveUI.pDiagonal(context, 0.3),
                    ),
                  ),
                  spacing40,
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(12.0),
              child: CommonButtonWidget(
                text: widget.productModel != null
                    ? "Actualizar Producto"
                    : "Agregar Producto",
                color: BrandColor.secondaryColor,
                onPressed: () {
                  if (widget.productModel == null) {
                    registerProduct();
                  } else {
                    updateProduct();
                  }
                },
              ),
            ),
          ),
          isLoading
              ? Container(
                  color: Colors.white,
                  child: loadingWidget,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
