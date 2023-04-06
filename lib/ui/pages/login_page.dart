import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoesappclient/models/user_model.dart';
import 'package:shoesappclient/services/local/sp_global.dart';
import 'package:shoesappclient/services/remote/firestore_service.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/pages/init_page.dart';
import 'package:shoesappclient/ui/pages/register_page.dart';
import 'package:shoesappclient/ui/widgets/common_button_widget.dart';
import 'package:shoesappclient/ui/widgets/common_input_widget.dart';
import 'package:shoesappclient/ui/widgets/common_password_widget.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';
import 'package:shoesappclient/utils/responsive.dart';
import 'package:shoesappclient/utils/types.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  FirestoreService firestoreService = FirestoreService();

  final formKeyLogin = GlobalKey<FormState>();

  bool isLoading = false;

  login() async {
    try {
      if (formKeyLogin.currentState!.validate()) {
        isLoading = true;
        setState(() {});
        UserCredential userCredencial =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (userCredencial.user != null) {
          UserModel? userModel =
              await firestoreService.getUser("jvillavicencio@nisira.com.pe");
          if (userModel != null) {
            SPGlobal().fullName = userModel.name;
            SPGlobal().isLogin = true;
            SPGlobal().email = userModel.email;
            SPGlobal().typeLogin = "Fi";
            isLoading = false;
            setState(() {});
            //ignore: use_build_context_synchronously
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
      isLoading = false;
      setState(() {});
      if (e.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarError("La contraseña es incorrecta"),
        );
      } else if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarError("El correo electronico no esta registrado"),
        );
      } else if (e.code == "invalid-email") {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarError("Formato de correo erroneo"),
        );
      }
    }
  }

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ["email"]);
  loginWithGoogle() async {
    //Inicio Google
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount == null) {
      return;
    }
    //print(googleSignInAccount);
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    //Fin Google

    //Inicio Firebase
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    //Fin Firebase

    if (userCredential.user != null) {
      UserModel? userModel =
          await firestoreService.getUser(userCredential.user!.email!);

      if (userModel == null) {
        String created = await firestoreService.registerUser(
          UserModel(
            email: userCredential.user!.email!,
            name: userCredential.user!.displayName!,
            phone: userCredential.user!.phoneNumber == null
                ? ""
                : userCredential.user!.phoneNumber!,
            role: "client",
          ),
        );
        if (created.isNotEmpty) {
          //ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InitPage(),
            ),
          );
        }
      } else {
        //Shared Preferences
        SPGlobal().fullName = userModel.name;
        SPGlobal().isLogin = true;
        SPGlobal().email = userModel.email;
        SPGlobal().typeLogin = "Go";
        //ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InitPage(),
          ),
        );
      }
    }
  }

  loginWithFacebook() async {
    LoginResult loginResult = await FacebookAuth.instance.login();
    //print(loginResult.status);
    if (loginResult.status == LoginStatus.success) {
      //print(await FacebookAuth.instance.getUserData());
      Map<String, dynamic> userData = await FacebookAuth.instance.getUserData();

      AccessToken? accessToken = loginResult.accessToken;

      OAuthCredential credential =
          FacebookAuthProvider.credential(accessToken!.token);
      //print(credential);

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      //print(userCredential);

      if (userCredential.user != null) {
        UserModel? userModel =
            await firestoreService.getUser(userCredential.user!.email!);

        if (userModel == null) {
          String created = await firestoreService.registerUser(
            UserModel(
              email: userCredential.user!.email!,
              name: userCredential.user!.displayName!,
              phone: userCredential.user!.phoneNumber == null
                  ? ""
                  : userCredential.user!.phoneNumber!,
              role: "client",
            ),
          );
          if (created.isNotEmpty) {
            //ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InitPage(),
              ),
            );
          }
        } else {
          //Shared Preferences
          SPGlobal().fullName = userModel.name;
          SPGlobal().isLogin = true;
          SPGlobal().email = userModel.email;
          SPGlobal().typeLogin = "Fa";
          //ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InitPage(),
            ),
          );
        }
      }
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
                  key: formKeyLogin,
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
                      CommonInputWidget(
                        label: "Correo Electronico",
                        hintText: "Tu correo electronico",
                        icon: AssetData.iconMail,
                        controller: emailController,
                        inputType: InputTypeEnum.email,
                      ),
                      spacing20,
                      CommonPasswordWidget(
                        controller: passwordController,
                      ),
                      spacing40,
                      CommonButtonWidget(
                        text: "Iniciar Sesión",
                        color: BrandColor.secondaryColor,
                        onPressed: () {
                          login();
                        },
                      ),
                      spacing16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          H5(
                            text: "Aún no tienes una cuenta?  ",
                            color:
                                BrandColor.primaryFontColor.withOpacity(0.70),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                            child: H5(
                              text: "Regístrate",
                              fontWeight: FontWeight.w700,
                              color: BrandColor.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      spacing40,
                      CommonButtonWidget(
                        text: "Iniciar Sesión con Google",
                        color: Color(0xffEA4335),
                        icon: AssetData.iconGoogle,
                        onPressed: () {
                          loginWithGoogle();
                        },
                      ),
                      spacing20,
                      CommonButtonWidget(
                        text: "Iniciar Sesión con Facebook",
                        color: Color(0xff0D81EA),
                        icon: AssetData.iconFacebook,
                        onPressed: () {
                          loginWithFacebook();
                        },
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
