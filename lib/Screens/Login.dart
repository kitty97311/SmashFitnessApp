import 'package:exercise_app/Screens/Signup.dart';
import 'package:exercise_app/Screens/Profile.dart';
import 'package:exercise_app/Screens/TabsScreen.dart';
import 'package:exercise_app/Modals/UserModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';
import '../Themes.dart';
import '../AllText.dart';
import '../CustomWidgets/CustomDialogues.dart';

class Login extends StatefulWidget {
  int? type;
  Login({this.type});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  UserModal? userModal;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPass = FocusNode();

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusEmail.dispose();
    _focusPass.dispose();

    super.dispose();
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
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

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return "Please enter your email";
    }
    if (!(value.isNotEmpty && value.contains("@") && value.contains("."))) {
      return 'The E-mail Address must be a valid email address.';
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
        title: t.boldText(text: '', color: WHITE, size: 25),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ListView(
            children: <Widget>[
              const SizedBox(
                height: 120,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: t.boldText(text: 'Log In', size: 30, color: WHITE)),
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
                            EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        decoration: BoxDecoration(
                            border: Border.all(color: PRIMARY),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          controller: _emailController,
                          focusNode: _focusEmail,
                          keyboardType: TextInputType
                              .emailAddress, // Use email input type for emails.
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email address',
                            hintStyle:
                                TextStyle(color: LIGHT_GREY_TEXT, fontSize: 20),
                          ),
                          style: TextStyle(
                              color: WHITE, fontFamily: 'Bold', fontSize: 20),
                          // validator: (value) {
                          //   return _validateEmail(value!);
                          // },
                        )),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        decoration: BoxDecoration(
                            border: Border.all(color: PRIMARY),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          controller: _passController,
                          focusNode: _focusPass,
                          obscureText:
                              _obscureText, // Use secure text for passwords.
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Passwords',
                              hintStyle: TextStyle(
                                  color: LIGHT_GREY_TEXT, fontSize: 20),
                              suffixIconConstraints: const BoxConstraints(
                                minWidth: 50,
                                minHeight: 2,
                              ),
                              suffixIcon: InkWell(
                                  onTap: _toggle,
                                  child: Icon(
                                      _obscureText
                                          ? Icons.remove_red_eye_outlined
                                          : Icons.visibility_off_outlined,
                                      color: WHITE,
                                      size: 24))),
                          style: TextStyle(
                              color: WHITE, fontFamily: 'Bold', fontSize: 20),
                          // validator: (value) {
                          //   return _validatePassword(value!);
                          // },
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            // if (_formKey.currentState!.validate()) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //         content: Text('Processing Data')),
                            //   );
                            // }
                            if (_validateEmail(_emailController.text) != null) {
                              showCustomDialog(
                                  context: context,
                                  title: ERROR,
                                  msg: _validateEmail(_emailController.text),
                                  btnYesText: OK,
                                  onPressedBtnYes: () {
                                    Navigator.pop(context);
                                  });
                              return;
                            }
                            if (_validatePassword(_passController.text) !=
                                null) {
                              showCustomDialog(
                                  context: context,
                                  title: ERROR,
                                  msg: _validatePassword(_passController.text),
                                  btnYesText: OK,
                                  onPressedBtnYes: () {
                                    Navigator.pop(context);
                                  });
                              return;
                            }
                            loginUser();
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
                                  text: 'Log In',
                                  color: BLACK,
                                  size: ipad ? 35 : 25),
                            ),
                          ),
                        )),
                    SizedBox(height: 30),
                    if (widget.type == 0)
                      Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Don't have an account yet? ",
                                style: TextStyle(color: WHITE, fontSize: 15)),
                            const TextSpan(text: ' '),
                            TextSpan(
                                text: "Register",
                                style: TextStyle(color: PRIMARY, fontSize: 18),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Signup()));
                                  }),
                          ]),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  loginUser() async {
    customDialogues.progressDialog(context: context, title: "Processing...");
    final _response = await http
        .get(Uri.parse(SERVER_ADDRESSLive +
            "/api/user_login?email=${_emailController.text}&password=${_passController.text}"))
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
    Navigator.pop(context);
    final _jsonResponse = jsonDecode(_response.body);
    if (_response.statusCode == 200 && _jsonResponse['success'] == "1") {
      customDialogues.progressDialog(
          context: context, title: ANALYZING_ANSWER[LANGUAGE_TYPE]);
      Map<String, dynamic> info = _jsonResponse['data'];
      userModal = UserModal.fromJson(_jsonResponse);
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setBool("isUserRegistered", true);
      sp.setBool("isMember", true);
      sp.setInt("memberID", info['id']);
      sp.setInt("commitperweek", 3);
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context);
        if (widget.type == 0)
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Profile()));
        if (widget.type == 1)
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TabsScreen()));
      });
    } else if (_response.statusCode == 200 && _jsonResponse['success'] == "0") {
      showCustomDialog(
          context: context,
          title: ERROR,
          msg: _jsonResponse['message'],
          btnYesText: OK,
          onPressedBtnYes: () {
            Navigator.pop(context);
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
}
