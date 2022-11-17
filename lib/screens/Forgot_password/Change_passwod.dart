import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epi_tracker/screens/Lets_street.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/ConstColors.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState>validator=GlobalKey<FormState>();
  bool passwordObscure = true;
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
                SizedBox(height: 70,),
                Container(
                  width: 149,
                  height: 42,
                  color: ConstColors.primaryColor,
                  child: Center(
                    child: Text("Epi Tracker",style: GoogleFonts.orbitron(
                        textStyle: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w700)
                    ),),
                  ),
                ),
                SizedBox(height: 24,),
                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5),
                  child: Text("Create New Password",style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: ConstColors.primaryColor,fontSize: 28,fontWeight: FontWeight.w700)
                  ),),
                ),
                SizedBox(height: 25,),
                Image.asset("assets/images/banner.png",height: 140),
                SizedBox(height: 25,),
                Row(
                  children: [
                    SizedBox(width: 20,),
                    Text("Password",style: GoogleFonts.inter(
                        textStyle: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400)
                    ),),
                  ],
                ),
                SizedBox(height: 10,),
                Container(
                  height: 63,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20,right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF5F5F5),
                     border: Border.all(color: ConstColors.primaryColor)
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: TextFormField(
                        controller: _password,
                        cursorColor: Colors.black54,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) => val!.length < 6 ? 'Password too short.' : null,
                        obscureText: passwordObscure,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  passwordObscure = !passwordObscure;
                                });
                              },
                              icon: passwordObscure?const Icon(Icons.visibility_off_sharp,color: Colors.black,size: 22,):const Icon(Icons.visibility,color: Colors.black,size: 22,),
                            )
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 13,),
                Row(
                  children: [
                    SizedBox(width: 20,),
                    Text("Confirm Password",style: GoogleFonts.inter(
                        textStyle: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400)
                    ),),
                  ],
                ),
                SizedBox(height: 10,),
                Container(
                  height: 63,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20,right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF5F5F5),
                      border: Border.all(color: ConstColors.primaryColor)
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: TextFormField(
                        controller: _password,
                        cursorColor: Colors.black54,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) => val!.length < 6 ? 'Password too short.' : null,
                        obscureText: passwordObscure,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  passwordObscure = !passwordObscure;
                                });
                              },
                              icon: passwordObscure?const Icon(Icons.visibility_off_sharp,color: Colors.black,size: 22,):const Icon(Icons.visibility,color: Colors.black,size: 22,),
                            )
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 63,),
                InkWell(
                  onTap: ()async{
                    if(validator.currentState!.validate()){
                      try{
    await FirebaseAuth.instance.currentUser!.updatePassword(_password.text);
                        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
                            {
                              'password':_password.text,
                            }
                        );
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password is Updated")));
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LetsStart()));
                      }catch(e){
                        print(e);
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error Occur enter Again")));
                      }
                    }},
                  child: Container(
                    height: 53,
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 20,right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: ConstColors.primaryColor
                    ),
                    child: Center(
                      child: Text("Confirm",style: GoogleFonts.inter(textStyle: TextStyle(
                          fontSize: 24,fontWeight: FontWeight.w700,color: Colors.white
                      )),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
