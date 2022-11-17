import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epi_tracker/screens/Login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/BottomBar.dart';
import '../constants/ConstColors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> validator = GlobalKey<FormState>();
  bool passwordObscure = true;
  bool isChecked = false;
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: validator,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: ConstColors.background,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Container(
                  width: 149,
                  height: 42,
                  color: ConstColors.primaryColor,
                  child: Center(
                    child: Text(
                      "Epi Tracker",
                      style: GoogleFonts.orbitron(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 63,
                ),
                Text(
                  "Sign Up",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: ConstColors.primaryColor,
                          fontSize: 32,
                          fontWeight: FontWeight.w700)),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  height: 63,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [BoxShadow(blurRadius: 0.1)]),
                  child: Center(
                    child: TextFormField(
                      controller: _username,
                      cursorColor: Colors.black54,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: "Username",
                        hintStyle: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                        contentPadding: EdgeInsets.only(
                          left: 22,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 63,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [BoxShadow(blurRadius: 0.1)]),
                  child: Center(
                    child: TextFormField(
                      controller: _email,
                      cursorColor: Colors.black54,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Enter the email";
                        }
                        if (!RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(value)) {
                          return "Enter the valid Email";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                        contentPadding: EdgeInsets.only(
                          left: 22,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 63,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [BoxShadow(blurRadius: 0.1)]),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: TextFormField(
                        controller: _password,
                        cursorColor: Colors.black54,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) =>
                            val!.length < 6 ? 'Password too short.' : null,
                        obscureText: passwordObscure,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                            hintText: "Enter Password",
                            hintStyle: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black)),
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordObscure = !passwordObscure;
                                });
                              },
                              icon: passwordObscure
                                  ? const Icon(
                                      Icons.visibility_off_sharp,
                                      color: Colors.black,
                                      size: 22,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      color: Colors.black,
                                      size: 22,
                                    ),
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 63,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [BoxShadow(blurRadius: 0.1)]),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: TextFormField(
                        controller: _password,
                        cursorColor: Colors.black54,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) =>
                            val!.length < 6 ? 'Password too short.' : null,
                        obscureText: passwordObscure,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                            hintText: "Confirm Password",
                            hintStyle: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black)),
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordObscure = !passwordObscure;
                                });
                              },
                              icon: passwordObscure
                                  ? const Icon(
                                      Icons.visibility_off_sharp,
                                      color: Colors.black,
                                      size: 22,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      color: Colors.black,
                                      size: 22,
                                    ),
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() => isChecked = value!);
                      },
                      activeColor: ConstColors.primaryColor,
                      checkColor: Colors.white,
                    ),
                    Text(
                      "By clicking Sign Up you are agreeing to Terms \nand Conditions",
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.black)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    if (validator.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _email.text, password: _password.text);
                        if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .set({
                            "password": _password.text,
                            "email": _email.text,
                            "uid": FirebaseAuth.instance.currentUser!.uid,
                            "username": _username.text,
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Account Created Successfully")));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomBar()));
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "email-already-in-use") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Email Already Exist")));
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  // onTap: (){
                  //   if(validator.currentState!.validate()) {
                  //     Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomBar()));
                  //   }
                  // },
                  child: Container(
                    height: 53,
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: ConstColors.primaryColor),
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                      ),
                      Text(
                        " Login",
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
