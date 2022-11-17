import 'package:epi_tracker/components/BottomBar.dart';
import 'package:epi_tracker/constants/ConstColors.dart';
import 'package:epi_tracker/screens/Forgot_password/Email_verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> validator = GlobalKey<FormState>();
  bool passwordObscure = true;
  bool isChecked = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
void userlogin()async{
   await  FirebaseAuth.instance.currentUser;
  if(FirebaseAuth.instance.currentUser!.uid.isNotEmpty){
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => BottomBar()),
            (route) => false);
  }
  else
  {
// Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }
}
  void initState(){
    super.initState();
    userlogin();
  }
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
                  "Log In",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: ConstColors.primaryColor,
                          fontSize: 32,
                          fontWeight: FontWeight.w700)),
                ),
                SizedBox(
                  height: 63,
                ),
                Container(
                  height: 63,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(blurRadius: 0.1)]),
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
                            hintText: "Password",
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
                  height: 32,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmailVerification()));
                  },
                  child: Text(
                    "Forgot Password?",
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 40,
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
                      "Remember Me",
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 75,
                ),
                InkWell(
                  onTap: () async {
                    if (validator.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _email.text, password: _password.text);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => BottomBar()),
                                (route) => false
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Logged In")));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "user-not-found") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Email Not Exist")));
                        } else if (e.code == "wrong-password") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Incorrect Password")));
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  // onTap: (){
                  //   if(validator.currentState!.validate()) {
                  //
                  //     // Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomBar()));
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
                        "Log In",
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New Here?",
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                      ),
                      Text(
                        " Register",
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
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
