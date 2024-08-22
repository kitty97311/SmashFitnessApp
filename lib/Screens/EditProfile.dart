import 'package:exercise_app/Screens/Upload.dart';
import 'package:exercise_app/Screens/Upload2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';
import '../Themes.dart';
import '../AllText.dart';
import '../CustomWidgets/CustomDialogues.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _passOldController = TextEditingController();
  final _passNewController = TextEditingController();
  final _passConfirmController = TextEditingController();

  bool _obscureTextOld = true;
  bool _obscureTextNew = true;
  bool _obscureTextConfirm = true;

  String password = '';

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obscureTextOld = !_obscureTextOld;
      _obscureTextNew = !_obscureTextNew;
      _obscureTextConfirm = !_obscureTextConfirm;
    });
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: BLACK,
      appBar: AppBar(
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: BLACK,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: BLACK,
                boxShadow: [
                  BoxShadow(
                      color: LIGHT_GREY_TEXT, spreadRadius: 0.1, blurRadius: 4)
                ],
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Icon(
              Icons.arrow_back_ios,
              color: WHITE,
              size: 18,
            ),
          ),
        ),
        title: t.boldText(text: 'Edit Profile', color: WHITE, size: 25),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ListView(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: t.boldText(
                      text: 'Change Password', size: 25, color: WHITE)),
              const Padding(
                padding: EdgeInsets.only(bottom: 15.0),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: PRIMARY),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          controller: _passOldController,
                          obscureText:
                              _obscureTextOld, // Use secure text for passwords.
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Current Password',
                              hintStyle: TextStyle(
                                  color: LIGHT_GREY_TEXT, fontSize: 20),
                              suffixIconConstraints: const BoxConstraints(
                                minWidth: 50,
                                minHeight: 2,
                              ),
                              suffixIcon: InkWell(
                                  onTap: _toggle,
                                  child: Icon(
                                      _obscureTextOld
                                          ? Icons.remove_red_eye_outlined
                                          : Icons.visibility_off_outlined,
                                      color: WHITE,
                                      size: 24))),
                          style: TextStyle(
                              color: WHITE, fontFamily: 'Bold', fontSize: 20),
                        )),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: PRIMARY),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          controller: _passNewController,
                          obscureText:
                              _obscureTextNew, // Use secure text for passwords.
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'New Password',
                              hintStyle: TextStyle(
                                  color: LIGHT_GREY_TEXT, fontSize: 20),
                              suffixIconConstraints: const BoxConstraints(
                                minWidth: 50,
                                minHeight: 2,
                              ),
                              suffixIcon: InkWell(
                                  onTap: _toggle,
                                  child: Icon(
                                      _obscureTextNew
                                          ? Icons.remove_red_eye_outlined
                                          : Icons.visibility_off_outlined,
                                      color: WHITE,
                                      size: 24))),
                          style: TextStyle(
                              color: WHITE, fontFamily: 'Bold', fontSize: 20),
                        )),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: PRIMARY),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          controller: _passConfirmController,
                          obscureText:
                              _obscureTextConfirm, // Use secure text for passwords.
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(
                                  color: LIGHT_GREY_TEXT, fontSize: 20),
                              suffixIconConstraints: const BoxConstraints(
                                minWidth: 50,
                                minHeight: 2,
                              ),
                              suffixIcon: InkWell(
                                  onTap: _toggle,
                                  child: Icon(
                                      _obscureTextConfirm
                                          ? Icons.remove_red_eye_outlined
                                          : Icons.visibility_off_outlined,
                                      color: WHITE,
                                      size: 24))),
                          style: TextStyle(
                              color: WHITE, fontFamily: 'Bold', fontSize: 20),
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            if (_validatePassword(_passOldController.text) !=
                                null) {
                              showCustomDialog(
                                  context: context,
                                  title: ERROR,
                                  msg: _validatePassword(
                                      _passOldController.text),
                                  btnYesText: OK,
                                  onPressedBtnYes: () {
                                    Navigator.pop(context);
                                  });
                              return;
                            }
                            if (password != _passOldController.text) {
                              showCustomDialog(
                                  context: context,
                                  title: ERROR,
                                  msg: "Current password is not correct.",
                                  btnYesText: OK,
                                  onPressedBtnYes: () {
                                    Navigator.pop(context);
                                  });
                              return;
                            }
                            if (_validatePassword(_passNewController.text) !=
                                null) {
                              showCustomDialog(
                                  context: context,
                                  title: ERROR,
                                  msg: _validatePassword(
                                      _passNewController.text),
                                  btnYesText: OK,
                                  onPressedBtnYes: () {
                                    Navigator.pop(context);
                                  });
                              return;
                            }
                            if (_validatePassword(
                                    _passConfirmController.text) !=
                                null) {
                              showCustomDialog(
                                  context: context,
                                  title: ERROR,
                                  msg: _validatePassword(
                                      _passConfirmController.text),
                                  btnYesText: OK,
                                  onPressedBtnYes: () {
                                    Navigator.pop(context);
                                  });
                              return;
                            }
                            if (_passNewController.text !=
                                _passConfirmController.text) {
                              showCustomDialog(
                                  context: context,
                                  title: ERROR,
                                  msg:
                                      "Please match new password with confirm password.",
                                  btnYesText: OK,
                                  onPressedBtnYes: () {
                                    Navigator.pop(context);
                                  });
                              return;
                            }
                            updatePassword();
                          },
                          child: Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: MAINPADDING),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: PRIMARY,
                            ),
                            child: Center(
                              child: t.mediumText(
                                  text: 'Save',
                                  color: BLACK,
                                  size: ipad ? 35 : 25),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: t.boldText(
                      text: 'Upload images', size: 25, color: WHITE)),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UploadPage()));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: PRIMARY,
                      ),
                      child: Center(
                        child: t.mediumText(
                            text: 'Upload', color: BLACK, size: ipad ? 35 : 25),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 40,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: t.boldText(
                      text: 'Upload videos', size: 25, color: WHITE)),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UploadPage2()));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: PRIMARY,
                      ),
                      child: Center(
                        child: t.mediumText(
                            text: 'Upload', color: BLACK, size: ipad ? 35 : 25),
                      ),
                    ),
                  )),
              const Padding(
                padding: EdgeInsets.only(bottom: 15.0),
              ),
            ],
          )
        ],
      ),
    );
  }

  getUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    final _response = await http
        .get(Uri.parse(SERVER_ADDRESSLive +
            "/api/get_userinfo?id=" +
            sp.getInt('memberID').toString()))
        .catchError((e) {
      showCustomDialog(
          context: context,
          title: ERROR,
          msg: e.toString(),
          btnYesText: OK,
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
    });

    final _jsonResponse = jsonDecode(_response.body);
    if (_response.statusCode == 200 && _jsonResponse['success'] == "1") {
      Map<String, dynamic> info = _jsonResponse['data'];
      if (mounted)
        setState(() {
          password = info['password'];
        });
    } else {
      showCustomDialog(
          context: context,
          title: ERROR,
          msg: FAILED_TO_LOAD_DATA,
          btnYesText: OK,
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
    }
  }

  updatePassword() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final _response = await http
        .get(Uri.parse(SERVER_ADDRESSLive +
            "/api/update_password?id=" +
            sp.getInt('memberID').toString() +
            "&password=" +
            _passNewController.text.toString()))
        .catchError((e) {
      showCustomDialog(
          context: context,
          title: ERROR,
          msg: e.toString(),
          btnYesText: OK,
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
    });

    final _jsonResponse = jsonDecode(_response.body);
    if (_response.statusCode == 200 && _jsonResponse['success'] == "1") {
      showCustomDialog(
          context: context,
          title: "Success",
          msg: _jsonResponse['message'],
          btnYesText: OK,
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
      if (mounted) {
        setState(() {
          _passOldController.text = "";
          _passNewController.text = "";
          _passConfirmController.text = "";
        });
      }
    } else {
      showCustomDialog(
          context: context,
          title: ERROR,
          msg: FAILED_TO_LOAD_DATA,
          btnYesText: OK,
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
    }
  }
}
