import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoesappclient/models/user_model.dart';
import 'package:shoesappclient/services/local/sp_global.dart';
import 'package:shoesappclient/services/remote/firestore_service.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/pages/init_page.dart';
import 'package:shoesappclient/ui/widgets/common_button_widget.dart';
import 'package:shoesappclient/ui/widgets/common_input_widget.dart';
import 'package:shoesappclient/ui/widgets/common_password_widget.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';
import 'package:shoesappclient/utils/responsive.dart';
import 'package:shoesappclient/utils/types.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nombres = TextEditingController();

  TextEditingController telefono = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  bool isLoading = false;

  final formKeyRegister = GlobalKey<FormState>();

  registerUser() async {
    try {
      if (formKeyRegister.currentState!.validate()) {
        isLoading = true;
        setState(() {});
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        print(userCredential);

        if (userCredential.user != null) {
          FirestoreService firestoreService = FirestoreService();

          UserModel model = UserModel(
            email: email.text,
            name: nombres.text,
            phone: telefono.text,
            role: "client",
          );
          String value = await firestoreService.registerUser(model);
          if (value.isNotEmpty) {
            SPGlobal().fullName = nombres.text;
            SPGlobal().isLogin = true;
            SPGlobal().email = email.text;
            isLoading = false;
            setState(() {});
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InitPage(),
              ),
            );
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      print("error:::: ${e.code}");

      if (e.code == "weak-password") {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarError(
              "La contraseña es muy debil, debe tener como minimo 6 caracteres."),
        );
      } else if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarError("El correo electronico ya esta registrado"),
        );
      }
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          backgroundWidget(context),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: formKeyRegister,
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
                        text: "Registrate",
                      ),
                      spacing8,
                      CommonInputWidget(
                        label: "Nombres",
                        hintText: "Tus Nombres",
                        icon: AssetData.iconUser,
                        controller: nombres,
                        inputType: InputTypeEnum.text,
                      ),
                      spacing20,
                      CommonInputWidget(
                        label: "Telefono",
                        hintText: "Tus Telefono",
                        icon: AssetData.iconPhone,
                        controller: telefono,
                        inputType: InputTypeEnum.phone,
                      ),
                      spacing20,
                      CommonInputWidget(
                        label: "Correo Electronico",
                        hintText: "Tu correo electronico",
                        icon: AssetData.iconMail,
                        controller: email,
                        inputType: InputTypeEnum.email,
                      ),
                      spacing20,
                      CommonPasswordWidget(controller: password),
                      spacing40,
                      CommonButtonWidget(
                        text: "Registrate",
                        color: BrandColor.secondaryColor,
                        onPressed: () {
                          registerUser();
                        },
                      ),
                      spacing16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          H5(
                            text: "Ya tienes una cuenta?  ",
                            color:
                                BrandColor.primaryFontColor.withOpacity(0.70),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ),
                              );
                            },
                            child: H5(
                              text: "Inicia Sesión",
                              fontWeight: FontWeight.w700,
                              color: BrandColor.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          isLoading
              ? Container(
                  color: Colors.white70,
                  child: loadingWidget,
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
