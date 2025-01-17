import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jokes/Shammas_practise/page1_mode.dart';



class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  List<Product> Hello = [];
  void loaddata({String? value}) async {
    Dio dio = Dio();
    
    String Url = "https://www.freetestapi.com/api/v1/products";
    if (value != null) {
      Url += "?search=$value";
    }
    Response response = await dio.get(Url);
    
    if (response.statusCode == 200) {
      List<Product> data = [];
      for (var r in response.data) {
        data.add(Product.fromJson(r));
      }
      setState(() {
        Hello = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loaddata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _Buildui());
  }

  Widget _Buildui() {
    return SizedBox.expand(
      child: Column(
        children: [
          search(),
          Expanded(child: _Uidata()),
        ],
      ),
    );
  }

  Widget _Uidata() {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            itemCount: Hello.length,
            itemBuilder: (context, index) {
              Product p = Hello[index];
              return ListTile(
                title: Text(p.name.toString()),
                subtitle: Text(p.description.toString()),
                leading: Text(p.id.toString()),
                trailing: Column(
                  children: [
                    Text(p.price.toString()),
                    Text(p.brand.toString())
                  ],
                ),
              );
            }));
  }

  Widget search() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.80,
      child: SearchBar(
        onSubmitted: (value) {
          loaddata(value: value);
        },
      ),
    );
  }
}
