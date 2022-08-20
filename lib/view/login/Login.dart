import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:systel_project/model/authentication.dart';
import 'package:systel_project/view/register/register.dart';

import '../home/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  String email = '';
  String pass = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Authentication.initializeParse();
  }

  bool inCorrectLogIn = false;
  emailTextField() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 44,
      child: TextField(
        controller: emailController,
        onChanged: (value) {
          email = value;
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: 'Username or Email',
          contentPadding: EdgeInsets.all(0),
          hintStyle: TextStyle(color: Colors.black, fontSize: 19),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
    );
  }

  passwordTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width,
      height: 44,
      child: TextField(
        controller: passController,
        onChanged: (value) {
          pass = value;
        },
        // obscureText: show_pass,
        obscureText: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.black, fontSize: 19),
          contentPadding: EdgeInsets.all(0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  loginBtn() {
    return Center(
      child: GestureDetector(
        onTap: () async {
          setState(() {
            isSpinner = true;
          });
          Authentication.signInUser(emailController.text, passController.text)
              .then((response) {
            if (response.result.toString() != 'null') {
              setState(() {
                inCorrectLogIn = false;
                isSpinner = false;
              });
              print('user name = ${response.result['username']}');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Home(
                      username: response.result['username'],
                    );
                  },
                ),
              );
            } else {
              setState(() {
                inCorrectLogIn = true;
                isSpinner = false;
              });
            }
            print('response from user login = ${response.result.toString()}');
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 36.0, right: 36.0),
          child: Container(
            height: 60,
            width: 303,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xff0D77E2),
            ),
            child: Center(
              child: Text(
                'Login',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal),
              ),
            ),
          ),
        ),
      ),
    );
  }

  registerText() {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Register();
              },
            ),
          );
        },
        child: Center(
            child: Text(
          'Has No Account ? Register Now',
          style: TextStyle(
              color: Colors.red, decoration: TextDecoration.underline),
        )));
  }

  inCorrectCredentialsText() {
    return Center(
      child: Container(
        width: 230,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            color: Color(0xffFF2B2B)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Credentials are incorrect',
                style: TextStyle(fontSize: 15, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isSpinner = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xffF2F2F2),
            body: Builder(
              builder: (context) => ModalProgressHUD(
                  inAsyncCall: isSpinner,
                  child: Stack(
                    children: [
                      Image(
                          fit: BoxFit.cover,
                          image:
                              AssetImage('assets/images/loginBackground.png')),
                      Padding(
                          padding:
                              const EdgeInsets.only(left: 36.0, right: 36.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (inCorrectLogIn)
                                  ? inCorrectCredentialsText()
                                  : Container(),
                              SizedBox(
                                height: 10,
                              ),
                              emailTextField(),
                              SizedBox(
                                height: 16,
                              ),
                              passwordTextField(),
                              SizedBox(
                                height: 50,
                              ),
                              loginBtn(),
                              SizedBox(
                                height: 30,
                              ),
                              registerText()
                            ],
                          )),
                    ],
                  )),
            )));
  }
}
