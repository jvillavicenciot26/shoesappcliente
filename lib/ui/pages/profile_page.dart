import 'package:flutter/material.dart';
import 'package:shoesappclient/models/user_model.dart';
import 'package:shoesappclient/services/local/sp_global.dart';
import 'package:shoesappclient/services/remote/firestore_service.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/pages/login_page.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';

class ProfilePage extends StatelessWidget {
  FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    double cHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder(
        future: firestoreService.getUser(SPGlobal().email),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            UserModel? userModel = snap.data;
            return SafeArea(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: cHeight * 0.4,
                    color: BrandColor.primaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50.0,
                          child: Icon(
                            Icons.person,
                            color: BrandColor.primaryColor,
                            size: 60.0,
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          userModel!.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Datos Personales",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.phone,
                            ),
                            title: Text(
                              userModel!.phone,
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.email,
                            ),
                            title: Text(
                              userModel!.email,
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.work,
                            ),
                            title: Text(
                              userModel!.role,
                            ),
                          ),
                          Expanded(
                            child: SizedBox(),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  color: BrandColor.primaryColor,
                                  width: 2.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              child: Text(
                                "CERRAR SESIÓN",
                                style: TextStyle(
                                  color: BrandColor.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                SPGlobal().isLogin = false;
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                    (route) => false);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return loadingWidget;
        },
      ),
    );
  }
}
