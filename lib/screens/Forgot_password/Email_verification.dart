import 'package:email_auth/email_auth.dart';
import 'package:epi_tracker/screens/Forgot_password/Otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/ConstColors.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    GlobalKey<FormState> _key = GlobalKey<FormState>();
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ConstColors.background,
        child: SingleChildScrollView(
          child:Form (
            key: _key,
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
                SizedBox(height: 63,),
                Text("Forgot Password",style: GoogleFonts.poppins(
                    textStyle: TextStyle(color: ConstColors.primaryColor,fontSize: 32,fontWeight: FontWeight.w700)
                ),),
                SizedBox(height: 15,),
                Text("Enter Email linked to your account",style: GoogleFonts.inter(textStyle: TextStyle(
                    fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                )),),
                SizedBox(height: 35,),
                Container(
                  height: 63,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20,right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 0.1
                        )
                      ]
                  ),
                  child: Center(
                    child: TextFormField(
                      controller: _email,
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: GoogleFonts.inter(textStyle: TextStyle(
                            fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                        )),
                        contentPadding: EdgeInsets.only(left: 22,),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 280,),
                InkWell(
                  onTap: ()async{

                    EmailAuth.sessionName='Test Session';
                    var res = await EmailAuth.sendOtp(receiverMail: _email.text);
                    if (res){
                      print('Otp sent');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Otp Sent Successfully")));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerification(mail:_email.text)));

                    }else{
                      print('We could not sent Otp');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("We couldn't sent Otp Enter Email Again")));
                    }
                  },
                  // onTap: (){
                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerification()));
                  // },
                  child: Container(
                    height: 53,
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 20,right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: ConstColors.primaryColor
                    ),
                    child: Center(
                      child: Text("Send",style: GoogleFonts.inter(textStyle: TextStyle(
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
