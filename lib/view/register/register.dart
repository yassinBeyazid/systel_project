import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:systel_project/model/authentication.dart';
import 'package:systel_project/model/db_queries.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final usernameController = TextEditingController();
  String email = '';
  String username = '';
  String pass = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Authentication.initializeParse();
  }

  _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => new CupertinoAlertDialog(
        content: Column(
          children: [
            Icon(
              Icons.check,
              color: Colors.green,
              size: 50.0,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              message,
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }

  _showErrorDialog(context, String message) {
    showDialog(
      context: context,
      builder: (_) => new CupertinoAlertDialog(
        content: Column(
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
              size: 50.0,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              message,
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }

  usernameTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 36.0, right: 36.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 44,
        child: TextField(
          controller: usernameController,
          onChanged: (value) {
            username = value;
          },
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: 'Username',
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
      ),
    );
  }

  emailTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 36.0, right: 36.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 44,
        child: TextField(
          controller: emailController,
          onChanged: (value) {
            email = value;
          },
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: 'Email',
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
      ),
    );
  }

  passwordTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 36.0, right: 36.0),
      child: Container(
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
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: 'Password',
            contentPadding: EdgeInsets.all(0),
            hintStyle: TextStyle(color: Colors.black, fontSize: 19),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  registerBtn() {
    return Center(
      child: GestureDetector(
        onTap: () async {
          setState(() {
            isSpinner = true;
          });
          Authentication.registerUser(usernameController.text,
                  passController.text, emailController.text)
              .then((response) {
            if (response.success.toString() == 'true') {
              setState(() {
                isSpinner = false;
              });
              DBQueries.insertUser(usernameController.text, 820.0, '20/8', 0);
              Navigator.pop(context);
              _showSuccessDialog('User Registered Successfully');
            } else {
              setState(() {
                isSpinner = false;
              });
              String message = response.error!.message;
              _showErrorDialog(context, message);
            }
            print('response in register is ${response.result.toString()}');
            print('error in register is ${response.error.toString()}');
            print('success in register is ${response.success.toString()}');
            print('results in register is ${response.results.toString()}');
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
                'Resigter',
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

  bool isSpinner = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xffF2F2F2),
            body: Builder(
              builder: (contex) => ModalProgressHUD(
                inAsyncCall: isSpinner,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 7,
                    ),
                    usernameTextField(),
                    SizedBox(
                      height: 7,
                    ),
                    emailTextField(),
                    SizedBox(
                      height: 7,
                    ),
                    passwordTextField(),
                    SizedBox(
                      height: 50,
                    ),
                    registerBtn()
                  ],
                ),
              ),
            )));
  }
}
