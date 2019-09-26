import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:baca/src/models/wacana.dart';

class SelectSubject extends StatefulWidget {
  final String type;

  SelectSubject({
    @required this.type,
    Key key
  }) : super(key: key);
  
  @override
  _SelectSubjectState createState() => _SelectSubjectState();
}

class _SelectSubjectState extends State<SelectSubject> {

  List<WacanaModel> listWacana = [];

  @override
  void initState() {
    loadContent();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> loadContent() async {
    String jsonString = await rootBundle.loadString('assets/json/wacana.json');
    final List<dynamic> parsedJson = json.decode(jsonString);
    List<WacanaModel> tmpList = [];
    for (var i = 0; i < parsedJson.length; i++) {
      tmpList.add(WacanaModel.fromJson(parsedJson[i]));
    }
    if (this.mounted) {
      setState(() {
        listWacana = tmpList.where((wacana) => wacana.jenis == widget.type).toList();
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      primary: false,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Pilih Wacana', style: TextStyle(color: Colors.blueGrey[900]),),
                Text(widget.type.toUpperCase(), style: textTheme.caption,)
              ],
            ),
            floating: true,
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.blueGrey),
            brightness: Brightness.light,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15)
              )
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 7.5),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                WacanaModel wacana = listWacana[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
                  child: Material(
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => Navigator.pushNamed(context, 'read'),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              wacana.title,
                              style: TextStyle(color: Colors.blueGrey[900], fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 8,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(FontAwesomeIcons.file, size: 14, color: Colors.blueGrey[500],),
                                SizedBox(width: 4,),
                                Text(
                                  "${wacana.total} Kata",
                                  style: textTheme.subtitle.copyWith(color: Colors.blueGrey[400]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: listWacana.length,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 7.5),
          ),
        ],
      ),
    );
  }
}