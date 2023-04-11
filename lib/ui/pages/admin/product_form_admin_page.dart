import 'package:flutter/material.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/widgets/common_input_widget.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';
import 'package:shoesappclient/utils/responsive.dart';
import 'package:shoesappclient/utils/types.dart';

class ProductFormAdminPage extends StatefulWidget {
  @override
  State<ProductFormAdminPage> createState() => _ProductFormAdminPageState();
}

class _ProductFormAdminPageState extends State<ProductFormAdminPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController sizeController = TextEditingController();

  List<double> sizes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BrandColor.secondaryColor,
        title: H4(
          text: "Agregar Producto",
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonInputWidget(
              label: "Nombre de Producto",
              hintText: "Nombre de Producto",
              icon: AssetData.iconRocket,
              controller: nameController,
              inputType: InputTypeEnum.text,
            ),
            spacing20,
            H5(
              text: "Marca:",
              fontWeight: FontWeight.w500,
            ),
            spacing8,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: DropdownButton(
                value: "Adidas",
                isExpanded: true,
                borderRadius: BorderRadius.circular(20.0),
                underline: SizedBox(),
                items: [
                  DropdownMenuItem(
                    child: H5(text: "Adidas"),
                    value: "Adidas",
                  ),
                  DropdownMenuItem(
                    child: H5(text: "Nike"),
                    value: "Nike",
                  ),
                  DropdownMenuItem(
                    child: H5(text: "New Balance"),
                    value: "New Balance",
                  ),
                ],
                onChanged: (String? value) {},
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
                    controller: nameController,
                    inputType: InputTypeEnum.phone,
                  ),
                ),
                spacing16Width,
                Expanded(
                  child: CommonInputWidget(
                    label: "Descuento (%)",
                    hintText: "Descuento",
                    icon: AssetData.iconRocket,
                    controller: nameController,
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
                    controller: nameController,
                    inputType: InputTypeEnum.phone,
                  ),
                ),
                spacing16Width,
                Expanded(
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
                    hintText: "Tallas",
                    icon: AssetData.iconRocket,
                    controller: sizeController,
                    inputType: InputTypeEnum.phone,
                  ),
                ),
                spacing16Width,
                InkWell(
                  onTap: () {
                    double size = double.parse(sizeController.text);
                    sizes.add(size);
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: BrandColor.secondaryFontColor,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
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
                      offset: Offset(4, 4),
                    ),
                  ]),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: sizes.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: H5(text: "Talla: ${sizes[index]}"),
                    trailing: Icon(
                      Icons.delete_rounded,
                      size: 20,
                      color: Colors.redAccent,
                    ),
                  );
                },
              ),
            ),
            spacing40,
          ],
        ),
      ),
    );
  }
}
