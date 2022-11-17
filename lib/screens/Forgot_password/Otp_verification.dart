import 'package:epi_tracker/screens/Forgot_password/Change_passwod.dart';
import 'package:epi_tracker/screens/Forgot_password/Email_verification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:email_auth/email_auth.dart';

import '../../constants/ConstColors.dart';

class OtpVerification extends StatelessWidget {
  String mail;
   OtpVerification({Key? key,required this.mail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _pin=TextEditingController();
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ConstColors.background,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 70,),
              Text("Verification",style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: ConstColors.primaryColor,fontSize: 32,fontWeight: FontWeight.w700)
              ),),
              SizedBox(height: 12,),
              Text("OTP Verify",style: GoogleFonts.inter(
                  textStyle: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w700)
              ),),
              SizedBox(height: 20,),
              Text("You Will Get An OTP In",style: GoogleFonts.inter(
                  textStyle: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400)
              ),),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(mail,style: GoogleFonts.inter(
                      textStyle: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400)
                  ),),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EmailVerification()));
                      },
                      child: Text("   Change",style: GoogleFonts.inter(
                          textStyle: TextStyle(color: ConstColors.primaryColor,fontSize: 13,fontWeight: FontWeight.w700)
                      ),),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 49,),
              // Pinput(
              //   defaultPinTheme: PinTheme(
              //     height: 40,
              //     width: 40,
              //     decoration:  BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       border: Border.all(color: ConstColors.primaryColor),
              //     ),
              //     // color: Colors.grey
              //   ),
              //   focusedPinTheme: PinTheme(
              //       height: 40,
              //       width: 40,
              //       decoration:  BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(color: ConstColors.primaryColor)
              //       )
              //   ),
              //   // submittedPinTheme: PinTheme(
              //   //   height: 60,
              //   //   width: 60,
              //   //   decoration:  BoxDecoration(
              //   //       color: ConstColors.primaryColor,
              //   //       borderRadius: BorderRadius.circular(10)
              //   //   ),
              //   // ),
              //   length: 6,
              // ),
              Pinput(
                controller: _pin,
                defaultPinTheme: PinTheme(
                  height: 40,
                  width: 40,
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: ConstColors.primaryColor),
                  ),
                  // color: Colors.grey
                ),
                focusedPinTheme: PinTheme(
                    height: 45,
                    width: 50,
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color:ConstColors.primaryColor)
                    )
                ),
                submittedPinTheme: PinTheme(
                  height: 40,
                  width: 40,
                  decoration:  BoxDecoration(
                      color: ConstColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                length: 6,
              ),
              SizedBox(height: 50,),
              Text("Enter Valid OTP Number",style: GoogleFonts.inter(
                  textStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700)
              ),),
              SizedBox(height: 25,),
              Text("You will receive a 6 digit code",style: GoogleFonts.inter(
                  textStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700)
              ),),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't receive code?",style: GoogleFonts.inter(textStyle: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                  )),),
                  GestureDetector(
                    onTap: ()async{

                      EmailAuth.sessionName='Test Session';
                      var res = await EmailAuth.sendOtp(receiverMail:mail);
                      if (res){
                        print('Otp sent');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Otp Sent Successfully")));
                      }else{
                        print('We could not sent Otp');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("We couldn't sent Otp Enter Email Again")));
                      }
                    },
                    child: Text(" Resend",style: GoogleFonts.inter(textStyle: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black
                    )),),
                  ),
                ],
              ),
              SizedBox(height: 50,),
              InkWell(
                onTap: (){
                  var res = EmailAuth.validate(receiverMail: mail, userOTP: _pin.text);
                  if(res){
                    print('Email Verified');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email Id is Verified")));
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword()));

                  }else{
                    print('Invalid Otp');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Otp")));
                  }
                },
                // onTap: (){
                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword()));
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
    );
  }
}
