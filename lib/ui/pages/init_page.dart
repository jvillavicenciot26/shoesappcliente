import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/pages/brand_page.dart';
import 'package:shoesappclient/ui/pages/explore_page.dart';
import 'package:shoesappclient/ui/pages/home_page.dart';
import 'package:shoesappclient/ui/pages/profile_page.dart';
import 'package:shoesappclient/utils/asset_data.dart';

class InitPage extends StatefulWidget {
  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  int indexPage = 0;

  List<Widget> pages = [
    HomePage(),
    ExplorePage(),
    BrandPage(),
    Center(
      child: Text("Favoritos"),
    ),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[indexPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexPage,
        onTap: (int value) {
          indexPage = value;
          setState(() {});
        },
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        selectedItemColor: BrandColor.primaryFontColor,
        unselectedItemColor: BrandColor.primaryFontColor.withOpacity(0.45),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetData.iconStore,
              height: 22,
              color: indexPage == 0
                  ? BrandColor.primaryFontColor
                  : BrandColor.primaryFontColor.withOpacity(0.45),
            ),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetData.iconRocket,
              height: 22,
              color: indexPage == 1
                  ? BrandColor.primaryFontColor
                  : BrandColor.primaryFontColor.withOpacity(0.45),
            ),
            label: "Explorar",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetData.iconBrand,
              height: 22,
              color: indexPage == 2
                  ? BrandColor.primaryFontColor
                  : BrandColor.primaryFontColor.withOpacity(0.45),
            ),
            label: "Marcas",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetData.iconFavorite,
              height: 22,
              color: indexPage == 3
                  ? BrandColor.primaryFontColor
                  : BrandColor.primaryFontColor.withOpacity(0.45),
            ),
            label: "Favoritos",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetData.iconProfile,
              height: 22,
              color: indexPage == 4
                  ? BrandColor.primaryFontColor
                  : BrandColor.primaryFontColor.withOpacity(0.45),
            ),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
