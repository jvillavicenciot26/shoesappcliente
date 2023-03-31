import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoesappclient/models/product_model.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/ui/widgets/item_search_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';
import 'package:shoesappclient/utils/calculate.dart';

class SearchProduct extends SearchDelegate {
  List<ProductModel> products;

  SearchProduct({required this.products});

  @override
  String get searchFieldLabel => "Buscar producto ...";

  @override
  TextStyle get searchFieldStyle => TextStyle(
        fontSize: 14.0,
        color: BrandColor.primaryFontColor.withOpacity(0.80),
      );

  @override
  InputDecorationTheme get searchFieldDecorationTheme => InputDecorationTheme(
        filled: true,
        fillColor: Colors.black12,
        hintStyle: TextStyle(
          fontSize: 14.0,
          color: BrandColor.primaryFontColor.withOpacity(0.6),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 12.0,
        ),
      );

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context).copyWith(
        appBarTheme: AppBarTheme(
          toolbarHeight: 76.0,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: BrandColor.primaryFontColor.withOpacity(0.8),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.black.withOpacity(0.04),
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ); //.of implica que se copiara el widget de la funcion

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(
          Icons.close,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print("BUILDRESULTS!!!!!!");
    print(query);

    List<ProductModel> suggestion = products
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestion.length,
      itemBuilder: (BuildContext context, int index) {
        return ItemSearchWidget(
          product: suggestion[index],
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print("BUILDSUGGESTIONS!!!!!!");
    print(query);

    List<ProductModel> suggestion = products
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestion.length,
      itemBuilder: (BuildContext context, int index) {
        return ItemSearchWidget(
          product: suggestion[index],
        );
      },
    );
  }
}
