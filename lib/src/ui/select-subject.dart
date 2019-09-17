import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectSubject extends StatefulWidget {
  @override
  _SelectSubjectState createState() => _SelectSubjectState();
}

class _SelectSubjectState extends State<SelectSubject> {
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
                Text('SMA', style: textTheme.caption,)
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
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
                  child: Material(
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Wacana ${index + 1} - Tema Wacana",
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
                                  "12${index + 1} Kata",
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
              childCount: 10,
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