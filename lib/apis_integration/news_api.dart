import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BackendFunctions {
  Future<List> epilepsyNews() async {
  try {
    var resp = await http.get(Uri.parse(
        "https://free-news.p.rapidapi.com/v1/search?q=Epilepsy&lang=en"),
        headers: {
        "X-RapidAPI-Key":"029eed9344msh9ba7b424cd87c34p140839jsn37d8a70aa7d3"
        }
    );

    if (resp.statusCode == 200) {
      var data = json.decode(resp.body);
      print("-----++++++++++======-------------");

      print(data);
      return data["articles"];
    } else {
      return Future.error("API not Found");
    }
  } catch (e) {
    return Future.error("API not Found");
  }
}
}