import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/widgets/common_button_widget.dart';
import 'package:shoesappclient/ui/widgets/common_input_widget.dart';
import 'package:shoesappclient/ui/widgets/common_password_widget.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';
import 'package:shoesappclient/utils/responsive.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -ResponsiveUI.pDiagonal(context, 0.15),
            left: -ResponsiveUI.pDiagonal(context, 0.05),
            child: Stack(
              children: [
                Transform.rotate(
                  angle: pi / 3.5,
                  child: Container(
                    height: ResponsiveUI.pDiagonal(context, 0.4),
                    width: ResponsiveUI.pDiagonal(context, 0.4),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(90.0),
                      gradient: LinearGradient(
                        colors: [
                          BrandColor.secondaryFontColor,
                          BrandColor.primaryColor,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: BrandColor.primaryColor.withOpacity(0.05),
                          blurRadius: 12.0,
                          offset: Offset(6, 6),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: ResponsiveUI.pDiagonal(context, 0.1),
                    ),
                    H1(
                      text: "ShoesApp",
                    ),
                    spacing8,
                    H4(
                      text: "Iniciar Sesión",
                    ),
                    spacing8,
                    H5(
                      text: "Por favor ingresa tus credenciales",
                      color: BrandColor.primaryFontColor.withOpacity(0.80),
                    ),
                    spacing20,
                    CommonInputWidget(),
                    spacing20,
                    CommonPasswordWidget(),
                    spacing40,
                    CommonButtonWidget(
                      text: "Iniciar Sesión",
                      color: BrandColor.secondaryColor,
                    ),
                    spacing40,
                    CommonButtonWidget(
                      text: "Iniciar Sesión con Google",
                      color: Color(0xffEA4335),
                      icon: AssetData.iconGoogle,
                    ),
                    spacing20,
                    CommonButtonWidget(
                      text: "Iniciar Sesión con Facebook",
                      color: Color(0xff0D81EA),
                      icon: AssetData.iconFacebook,
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
