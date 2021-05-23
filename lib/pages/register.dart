import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/homePage.dart';
import 'package:todo_app/services/authService.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/background2.jpg'),
          )),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey[600].withOpacity(
                                0.3), //Color.fromRGBO(255, 255, 255, 0.2),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Center(
                                  child: Text(
                                    'Register',
                                    style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                TextFormField(
                                  controller: emailController,
                                  autofocus: false,
                                  style: GoogleFonts.hammersmithOne(
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                      labelText: "Email",
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.white,
                                      ),
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(25))),
                                ),
                                TextField(
                                  controller: passwordController,
                                  style: GoogleFonts.hammersmithOne(
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                      labelText: "Password",
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ),
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(25))),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        Color.fromRGBO(163, 39, 230, 1),
                                  ),
                                  onPressed: () async {
                                    await context.read<AuthService>().register(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                        );
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                        (route) => false);
                                  },
                                  child: Text(
                                    "Register",
                                    style: GoogleFonts.hammersmithOne(
                                        textStyle: TextStyle(
                                            color: Colors.white, fontSize: 25)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
