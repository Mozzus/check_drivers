import 'package:check_drivers/constants/colors.dart';
import 'package:check_drivers/elements/logic/requests.dart';
import 'package:check_drivers/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _currentUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Text(
                'Настройки',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
          elevation: 0.0,
          toolbarHeight: 50,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Text(
                        'IP-адрес подключения',
                        style: TextStyle(
                            color: ColorConstants.blackColor, fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Form(
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: () {
                          Form.of(primaryFocus.context).save();
                        },
                        child: Container(
                          height: 44,
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: ColorConstants.tertiaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 7.0, top: 12, bottom: 12),
                            child: TextFormField(
                                cursorColor: ColorConstants.greyColor,
                                keyboardType: TextInputType.emailAddress,
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(9.0),
                                  border: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  isDense: false,
                                  hintText: Request.commonUrl == null
                                      ? "Введите ip-адрес подключения"
                                      : Request.commonUrl,
                                  hintStyle: TextStyle(
                                      color: Request.commonUrl == null
                                          ? Colors.grey
                                          : Colors.black),
                                ),
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: ColorConstants.blackColor),
                                onSaved: (val) {
                                  _currentUrl = '$val';
                                }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        height: 56,
                        width: MediaQuery.of(context).size.width - 40,
                        child: TextButton(
                          child: Text('Сохранить'),
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(fontSize: 16),
                            primary: ColorConstants.blackColor,
                            backgroundColor: Color(0xFFF0C332),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            //Метод сохранения адреса API
                            //
                            setState(() {
                              Request.commonUrl = _currentUrl;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Container(
                        height: 56,
                        width: MediaQuery.of(context).size.width - 40,
                        child: TextButton(
                          child: Text('Выйти из аккаунта'),
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(fontSize: 16),
                            primary: ColorConstants.redColor,
                            backgroundColor: ColorConstants.tertiaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
