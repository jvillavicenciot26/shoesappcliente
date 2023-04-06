import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';

class CommonPasswordWidget extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  CommonPasswordWidget({
    required this.controller,
  });

  @override
  State<CommonPasswordWidget> createState() => _CommonPasswordWidgetState();
}

class _CommonPasswordWidgetState extends State<CommonPasswordWidget> {
  bool isInvisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        H5(
          text: "  Contraseña",
          fontWeight: FontWeight.w600,
        ),
        spacing8,
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12.0,
                offset: Offset(4, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: isInvisible,
            decoration: InputDecoration(
              prefixIcon: SvgPicture.asset(
                AssetData.iconLock,
                fit: BoxFit.scaleDown,
                height: 20.0,
                color: BrandColor.primaryFontColor.withOpacity(0.60),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isInvisible
                      ? Icons.remove_red_eye_sharp
                      : Icons.remove_red_eye_outlined,
                  color: BrandColor.secondaryColor.withOpacity(0.60),
                ),
                onPressed: () {
                  isInvisible = !isInvisible;
                  setState(() {});
                  // //Para que cambie la propiedad despues de 2 segundos
                  // Future.delayed(
                  //   Duration(seconds: 2),
                  //   () {
                  //     isInvisible = !isInvisible;
                  //     setState(() {});
                  //   },
                  // );
                },
              ),
              hintText: "Tu contraseña",
              hintStyle: TextStyle(
                fontSize: 14.0,
                color: BrandColor.primaryFontColor.withOpacity(0.6),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0,
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
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (String? value) {
              if (value != null && value.isEmpty) {
                return "Campo obligatorio";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
