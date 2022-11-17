import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import '../apis_integration/news_api.dart';
import '../constants/ConstColors.dart';

class EpiNews extends StatefulWidget {
  const EpiNews({Key? key}) : super(key: key);

  @override
  State<EpiNews> createState() => _EpiNewsState();
}

class _EpiNewsState extends State<EpiNews> {
  BackendFunctions backendFunctions = BackendFunctions();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ConstColors.background,
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
            SizedBox(height: 60,),
            Container(height: 60,width: double.infinity,margin: EdgeInsets.only(left: 20,right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
              border: Border.all(color: ConstColors.primaryColor)
            ),
              child: Center(
                child: Text("Epilepsy Health News",style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24)
                ),),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.57,
              child: FutureBuilder<List>(
                  future: backendFunctions.epilepsyNews(),
                  builder: (context, snap) {
                    if(snap.hasData){
                      var data= snap.data![0];
                      return ListView.builder(
                          itemCount: snap.data!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8,bottom: 8),
                              child: Container(
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
                                child: ListTile(
                                  leading: Image.network(snap.data![index]["media"],height: 60,width: 100,),
                                  title: InkWell(
                                    onTap: () async {
                                      final Uri url = Uri.parse((snap.data![index]["link"]));
                                      launchUrl(url);
                                    },
                                    child: Text(snap.data![index]["title"],
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.black,fontSize: 14,fontWeight: FontWeight.w700
                                          )
                                      ),),
                                  ),
                                  subtitle: Text((snap.data![index]["clean_url"]),
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.blue,fontSize: 14,fontWeight: FontWeight.w600
                                        )
                                    ),),
                                )
                              ),
                            );
                          }
                      );
                    }
                    else{
                      return CupertinoActivityIndicator();
                    }
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
