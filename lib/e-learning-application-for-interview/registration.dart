import 'package:e_learning_application/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../DB_HElper/dbhelper.dart';
import 'login.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _Fname = TextEditingController();
  final _Lname = TextEditingController();
  var _email = TextEditingController();
  final _pass = TextEditingController();
  final _cpass = TextEditingController();

  DBHelper _dbHelper = DBHelper();

  Future<void> adduserData(BuildContext context, User user) async {
    var id = await _dbHelper.insert(user);
    if (id != -1) {
      print("Added Successfully ");
    } else {
      print("Error!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(child: Container()),
              SvgPicture.asset("assets/images/1.svg", height: 200, width: 200,),
              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: _Fname,
                          decoration: InputDecoration(
                              fillColor: Colors.grey,
                              filled: true,
                              hintText: "First Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: Icon(Icons.account_circle)
                          )

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: _Lname,
                          decoration: InputDecoration(
                              fillColor: Colors.grey,
                              filled: true,
                              hintText: "Last Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: Icon(Icons.account_circle)
                          )

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                              fillColor: Colors.grey,
                              filled: true,
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: Icon(Icons.mail)
                          )

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _pass,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Password",
                            fillColor: Colors.grey,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Icon(Icons.remove_red_eye_sharp)
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: _cpass,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Confirm Password",
                              fillColor: Colors.grey,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: Icon(Icons.remove_red_eye_sharp)
                          )

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //Text("Forgot Password?",style: TextStyle(fontWeight: FontWeight.bold),),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        onPressed: () {
                          String fname = _Fname.text.toString().trim();
                          String lname = _Lname.text.toString().trim();
                          String email = _email.text.toString().trim();
                          String pass = _pass.text.toString().trim();
                          User _user = User(fname: fname,
                              email: email,
                              lname: lname,
                              pass: pass);
                          adduserData(context, _user);
                        },
                        child: Text("Sign up", style: TextStyle(color: Colors
                            .white),),
                        height: 20,
                        color: Colors.purple,
                        padding: EdgeInsets.all(10),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                        child: Text("Login"),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}