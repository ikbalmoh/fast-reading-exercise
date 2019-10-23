import 'dart:async';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Status {
  none,
  running,
  stopped
}

class Read extends StatefulWidget {
  @override
  _ReadState createState() => _ReadState();
}

class _ReadState extends State<Read> {
  String content = '';
  List<String> arrayContent = [];

  int lastReadIndex = 0;
  Status status = Status.none;
  int readTime = 0;

  ScrollController _scrollController;

  Timer _timer;

  @override
  void initState() {
    _scrollController = ScrollController();
    loadContent();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  loadContent() async {
    final String contentString = await rootBundle.loadString('assets/txt/wacana.txt');
    final List<String> words = contentString.split(" ");
    setState(() {
      content = contentString;
      arrayContent = words;
    });
  }

  togleAction() {
    switch (status) {
      case Status.none:
        setState(() {
          status = Status.running;
        });
        runTimer();
        break;
      case Status.running:
        setState(() {
          status = Status.stopped;
        });
        _timer.cancel();
        break;
      default:
        Navigator.pop(context);
        break;
    }
  }

  runTimer() {
    _timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (this.mounted) {
        setState(() {
          readTime = readTime + 1;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes);
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Color buttonColor() {
    switch (status) {
      case Status.stopped:
        if (lastReadIndex > 0) {
          return Colors.green;
        }
        return Colors.grey[400];
      default:
        return Colors.red;
    }
  }

  Future<bool> _exitPage(BuildContext context) {
    if (status == Status.running) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            elevation: 6,
            title: Text('Keluar dari halaman?'),
            content: Text('Anda belum selesai membaca'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Tidak'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Ya'),
                textColor: Colors.grey,
              )
            ],
          );
        },
      ) ?? false;
    }
    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitPage(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Wacana", 
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.blueGrey),
          actions: <Widget>[
            status != Status.none ?
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(_printDuration(Duration(seconds: readTime)), style: TextStyle(color: Colors.black),)),
            ) : Container()
          ],
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 80),
              controller: _scrollController,
              physics: status == Status.running ? AlwaysScrollableScrollPhysics() : NeverScrollableScrollPhysics(),
              child:  Container(
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                    children: arrayContent.asMap().map((i, word) {
                      final String text = word.contains("[NEWLINE]") ? word.replaceAll("[NEWLINE]", "\n") : "$word ";
                      TextStyle textStyle = TextStyle(
                        backgroundColor: lastReadIndex == i + 1 ? Colors.yellow : Colors.transparent
                      );
                      return MapEntry(i, TextSpan(text: text, 
                        recognizer: TapGestureRecognizer()..onTap = () {
                          if (status == Status.stopped) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return new DoneDialog(lastReadIndex: lastReadIndex, readTime: readTime);
                              }
                            );
                            print("${i+1} => $word");
                            setState(() {
                              lastReadIndex = i + 1;
                            });
                            double kpm = (i + 1 / readTime) * 60;
                            print('Kecepatan Membaca: $kpm');
                          }
                        },
                        style: textStyle,
                      ));
                    }).values.toList()
                  ),
                ),
              ),
            ),
            status == Status.none ? Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5
                ),
                child: Container(
                  color: Colors.black.withOpacity(0),
                  child: Center(
                    child: RaisedButton.icon(
                      icon: Icon(Icons.play_arrow),
                      label: Text('MULAI'),
                      onPressed: togleAction,
                      color: Colors.green,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                  ),
                ),
              ),
            ) : Container(),
            Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: AnimatedOpacity(
                opacity: status == Status.stopped && lastReadIndex == 0 ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red[300],
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(color: Colors.grey, blurRadius: 5)
                    ]
                  ),
                  child: Center(
                    child: Text(
                      'Ketuk kata terakhir yang dibaca',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.stop),
          label: Text('SELESAI'),
          onPressed: togleAction,
          backgroundColor: Colors.red,
        ) : Container(),
      )
    );
  }
}

class DoneDialog extends StatelessWidget {
  const DoneDialog({
    Key key,
    @required this.lastReadIndex,
    @required this.readTime,
  }) : super(key: key);

  final int lastReadIndex;
  final int readTime;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      elevation: 6,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0.0, 10.0)
            )
          ]
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Hebat!",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              "Kamu membaca $lastReadIndex kata\ndalam $readTime detik",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 24.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.blue,
                  colorBrightness: Brightness.dark,
                  child: Text("LANJUTKAN TES PEMAHAMAN"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  textColor: Colors.grey[400],
                  child: Text("HITUNG KECEPATAN SAJA"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}