import 'package:exercise_app/Screens/Login.dart';
import 'package:exercise_app/Screens/Profile.dart';
import 'package:exercise_app/Modals/UserModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

import '../main.dart';
import '../Themes.dart';
import '../AllText.dart';
import '../CustomWidgets/CustomDialogues.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  UserModal? userModal;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final FocusNode _focusUser = FocusNode();
  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPass = FocusNode();

  bool _obscureText = true;
  bool _isChecked = false;
  bool _checkConfirm = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusUser.dispose();
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

  String? _validateUsername(String value) {
    if (value.isEmpty) {
      return 'Please enter your name';
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
                  child: t.boldText(text: 'Sign Up', size: 30, color: WHITE)),
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
                          controller: _usernameController,
                          focusNode: _focusUser,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'User Name',
                            hintStyle:
                                TextStyle(color: LIGHT_GREY_TEXT, fontSize: 20),
                          ),
                          style: TextStyle(
                              color: WHITE, fontFamily: 'Bold', fontSize: 20),
                          // validator: (value) {
                          //   return _validateUsername(value!);
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
                            if (_validateUsername(_usernameController.text) !=
                                null) {
                              showCustomDialog(
                                  context: context,
                                  title: ERROR,
                                  msg: _validateUsername(
                                      _usernameController.text),
                                  btnYesText: OK,
                                  onPressedBtnYes: () {
                                    Navigator.pop(context);
                                  });
                              return;
                            }
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
                            registerUser();
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
                                  text: 'Sign Up',
                                  color: BLACK,
                                  size: ipad ? 35 : 25),
                            ),
                          ),
                        )),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(color: WHITE, fontSize: 15)),
                          const TextSpan(text: ' '),
                          TextSpan(
                              text: "Login",
                              style: TextStyle(color: PRIMARY, fontSize: 18),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Login(type: 0)));
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

  registerUser() async {
    customDialogues.progressDialog(
        context: context, title: SAVING_INFO[LANGUAGE_TYPE]);
    var request = http.MultipartRequest(
        'POST', Uri.parse('$SERVER_ADDRESSLive/api/user_register'));
    // print('name------------${nameController.text}');
    // print('phone------------${phoneController.text}');
    // print('gender------------${typeToGender(selectedGender)}');
    // print(
    //     'workout_intensity------------${typeToIntensity(selectedIntenseLevel)}');
    // print('age------------${currentAge.toString()}');
    // print(
    //     'height------------${currentBirth.toString() + " " + CENTIMETERS[LANGUAGE_TYPE]}');
    // print('exercise days------------${typeToDays(selectedTimesInWeek)}');

    final random = Random();
    final randomNumber = random.nextInt(9000000) + 1000000;

    request.fields.addAll({
      'name': _usernameController.text,
      'phone': randomNumber.toString(),
      'email': _emailController.text,
      'password': _passController.text,
      'gender': "Male",
      'workout_intensity': "typeToIntensity(selectedIntenseLevel)",
      'age': '16',
      'height':
          "currentHeight[0].toString()" + " " + CENTIMETERS[LANGUAGE_TYPE],
      'exercise_days': ALL_SEVEN_DAYS[LANGUAGE_TYPE],
      'token': "abc",
      'type': 'android',
    });

    http.StreamedResponse response = await request.send();
    Navigator.pop(context);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      if (jsonResponse['success'] == '0') {
        showCustomDialog(
            context: context,
            title: ERROR,
            msg: jsonResponse['message'],
            btnYesText: OK,
            onPressedBtnYes: () {
              Navigator.pop(context);
            });
      } else {
        customDialogues.progressDialog(
            context: context, title: ANALYZING_ANSWER[LANGUAGE_TYPE]);
        print('response ---------$jsonResponse');
        Map<String, dynamic> info = jsonResponse['data'];
        userModal = UserModal.fromJson(jsonResponse);
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setBool("isUserRegistered", true);
        sp.setBool("isMember", true);
        sp.setInt("memberID", info['id']);
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Profile()));
        });
      }
    } else {
      showCustomDialog(
          context: context,
          title: ERROR,
          msg: "Something is wrong. Please try it again later.",
          btnYesText: OK,
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
      print('msg error------${response.reasonPhrase}');
    }
  }
}
