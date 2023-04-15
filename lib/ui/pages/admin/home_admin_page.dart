import 'package:flutter/material.dart';
import 'package:shoesappclient/ui/pages/admin/dashboard_admin_page.dart';
import 'package:shoesappclient/ui/pages/admin/product_admin_page.dart';
import 'package:shoesappclient/ui/pages/admin/reports_admin_page.dart';
import 'package:shoesappclient/ui/widgets/admin/item_menu_widget.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';

class HomeAdminPage extends StatelessWidget {
  const HomeAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          backgroundWidget(context),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    spacing30,
                    H1(
                      text: "Bienvenido al adminstrador de ShoesApp",
                      height: 1.1,
                    ),
                    spacing12,
                    H5(
                      text: "Puedes gestionar todo desde aqui",
                    ),
                    GridView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      children: [
                        ItemMenuWidget(
                          text: "Productos",
                          icon: AssetData.imageProducts,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductAdminPage(),
                              ),
                            );
                          },
                        ),
                        ItemMenuWidget(
                          text: "Categorias",
                          icon: AssetData.imageTag,
                          onTap: () {},
                        ),
                        ItemMenuWidget(
                          text: "Clientes",
                          icon: AssetData.imageClient,
                          onTap: () {},
                        ),
                        ItemMenuWidget(
                          text: "Reportes",
                          icon: AssetData.imageReports,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReportAdminPage()));
                          },
                        ),
                        ItemMenuWidget(
                          text: "Dashboard",
                          icon: AssetData.imageChart,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DashboardAdminPage()));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
