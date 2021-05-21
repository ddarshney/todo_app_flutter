import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/pages/register.dart';
import 'package:todo_app/pages/signInPage.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                  child: Center(
                                child: Text(
                                  'Your Todo List',
                                  style: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )),
                              Expanded(
                                  flex: 6,
                                  child: SvgPicture.asset(
                                    'assets/images/landing.svg',
                                  )),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage()));
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        Color.fromRGBO(163, 39, 230, 1),
                                  ),
                                  child: Text(
                                    'Get Started',
                                    style: GoogleFonts.hammersmithOne(
                                        textStyle: TextStyle(
                                            color: Colors.white, fontSize: 25)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignInPage()));
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  child: Text(
                                    'Log In',
                                    style: GoogleFonts.hammersmithOne(
                                        textStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(163, 39, 230, 1),
                                            fontSize: 25)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        Color.fromRGBO(163, 39, 230, 1),
                                  ),
                                  child: Text(
                                    'Google Sign In',
                                    style: GoogleFonts.hammersmithOne(
                                        textStyle: TextStyle(
                                            color: Colors.white, fontSize: 25)),
                                  ),
                                ),
                              ),
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
    );
  }
}
