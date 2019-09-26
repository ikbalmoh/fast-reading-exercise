import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class About extends StatefulWidget {
  final String id;

  About({
    @required this.id,
    Key key
  }) : super(key: key);
  
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  String title;
  String data;

  @override
  void initState() {
    setState(() {
      title = '...';
      data = '...';
    });
    loadData();
    super.initState();
  }
  
  Future<void> loadData() async {
    String jsonString = await rootBundle.loadString('assets/json/app.json');
    final List<dynamic> parsedJson = json.decode(jsonString); 
    final dataObject = parsedJson.firstWhere((item) => item['id'] == widget.id, orElse: () => null);
    print(dataObject);
    if (dataObject != null) {
      String content = await rootBundle.loadString(dataObject['content']);
      print(content);
      setState(() {
        title = dataObject['title'];
        data = content;
      });
    } else {
      Navigator.pop(context);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30)
          )
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            "$data", 
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              height: 1.25
            ),
          ),
        ),
      )
    );
  }
}