import 'package:check_drivers/constants/colors.dart';
import 'package:check_drivers/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;

  String _password;

  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 128.0),
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/images/logo.svg",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'электронный пропуск',
                      style: TextStyle(
                          fontSize: 16, color: ColorConstants.blackColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 48.0),
                    child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'Логин',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: ColorConstants.blackColor),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Container(
                                height: 44,
                                width: MediaQuery.of(context).size.width - 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: ColorConstants.tertiaryColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 12, bottom: 12),
                                  child: TextFormField(
                                    cursorColor: ColorConstants.greyColor,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: ColorConstants.blackColor),
                                    onSaved: (val) => _email = val,
                                    validator: (val) => val == "ru" ? null : "",
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 20.0),
                                child: Text(
                                  'Пароль',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: ColorConstants.blackColor),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Container(
                                height: 44,
                                width: MediaQuery.of(context).size.width - 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: ColorConstants.tertiaryColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 12, bottom: 12),
                                  child: TextFormField(
                                    cursorColor: ColorConstants.greyColor,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: ColorConstants.blackColor),
                                    onSaved: (val) => _password = val,
                                    validator: (val) =>
                                        val == "1234" ? null : "",
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Container(
                                height: 56,
                                width: MediaQuery.of(context).size.width - 40,
                                child: TextButton(
                                  child: Text('Войти'),
                                  style: TextButton.styleFrom(
                                    textStyle: TextStyle(fontSize: 16),
                                    primary: Color(0xFF1B1512),
                                    backgroundColor: Color(0xFFF0C332),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    final form = formKey.currentState;
                                    if (form.validate()) {
                                      form.save();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Неверный логин или пароль')));
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
