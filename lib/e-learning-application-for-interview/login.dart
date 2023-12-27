import 'package:e_learning_application/e-learning-application-for-interview/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../DB_HElper/dbhelper.dart';
import '../prefrence/sharedpreference.dart';
import 'dashboard.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final email  = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? emails,Password;
  DBHelper dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.purple,
      body: Center(
        child: Column(
          children: [
            Expanded(

                flex: 1,child: Container()),
            SvgPicture.asset("assets/images/1.svg",height: 200,width: 200,),
            Expanded(
              flex: 4,
              child: Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: TextFormField(
                              controller: email,
                              validator: (value) {
                                if(value == null ){
                                  return "Enter the Valid Email";
                                }else{
                                  return null;
                                }
                              },
                              onSaved: (newValue) {
                                emails = newValue.toString();
                              },

                              decoration: InputDecoration(
                                  fillColor: Colors.grey,
                                  filled: true,
                                  hintText: "Email",
                                  errorText: emails,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  prefixIcon:Icon(Icons.supervised_user_circle)
                              )

                          ),
                        ),SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            obscureText: true,
                              controller: password,
                              validator: (value) {
                                if(value == null || value.isEmpty){
                                  return "The  PassWord is Mismatch ";
                                }else{
                                  return null;
                                }
                              },
                              onSaved: (newValue) {
                                Password = newValue.toString();
                              },
                              decoration: InputDecoration(
                                  errorText: Password,
                                  hintText: "Password",
                                  fillColor: Colors.grey,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  prefixIcon:Icon(Icons.lock),
                                  suffixIcon: Icon(Icons.remove_red_eye_sharp)
                              )

                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(child: Text("Forgot Password?",style: TextStyle(fontWeight: FontWeight.bold),)),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          onPressed: () async {
                            if(_formKey.currentState!.validate()){
                              _formKey.currentState!.save();

                              bool ischeck =await dbHelper.isLoginUser(emails!, Password!);

                              if(ischeck){
                                PrefManager.updateLoginStatus(true);
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DashboardScreen(),), (route) => false);
                              }else{
                                print('Invalid email and password');

                              }
                            }
                          },
                          child: Text("Login",style: TextStyle(color: Colors.white),),
                          height: 20,
                          color: Colors.purple,
                          padding: EdgeInsets.all(10),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(child: InkWell(

                            onTap: () {
                              Navigator.push(context,MaterialPageRoute(builder: (context) => Registration(),) );
                            },
                            child: Text("SIGN UP")))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                )),
          ],
        ),
      ),
    );
  }
}
