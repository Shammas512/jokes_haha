import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jokes/jokes/jokes_model.dart';

class jokes extends StatefulWidget {
  const jokes({super.key});

  @override
  State<jokes> createState() => _jokesState();
}

class _jokesState extends State<jokes> {
  bool inprogress = false;
  String joke = "Please Press The Generate Button";
  apicall() async {
    String url = "https://v2.jokeapi.dev/joke/Programming";

    try {
      final responce = await http.get(Uri.parse(url));

      if (responce.statusCode == 200) {
        setState(() {
          inprogress = false;
        });
        print("Api Get Complete");
        var data = jsonDecode(responce.body);

        if (data["type"] == "single") {
          setState(() {
            joke = (data["joke"]);
          });
          print("single");
        } else {
          jokes_model jokee = jokes_model.fromJson(data);
          setState(() {
            joke = "One :\n ${jokee.setup}" + "\n Other :\n${jokee.delivery}";
          });

          print(jokee.toJson());
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4169E1),
        title: Text(
          "Laughing Life ",
          style: TextStyle(letterSpacing: 1.5),
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: inprogress ? CircularProgressIndicator() : Text(joke,textAlign: TextAlign.center,),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            OutlinedButton(
              onPressed: () {
                apicall();
                setState(() {
                  inprogress = true;
                });
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                    color: Colors.blue, width: 2), // Border color and width
                foregroundColor: Colors.blue,
              ),
              child: Text("Generate Joke"),
            )
                    ],
                  ),
          )),
    );
  }
}
