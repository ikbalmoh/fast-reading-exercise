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
    _timer.cancel();
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

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          status == Status.none ? "" : 
            "${_printDuration(Duration(seconds: readTime))}", 
          style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          status != Status.stopped ?
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton.icon(
              label: Text(status == Status.none ? 'MULAI' : 'SELESAI'),
              onPressed: togleAction,
              color: status == Status.none ? Colors.green : Colors.red,
              icon: Icon(status == Status.none ? Icons.play_arrow : Icons.stop),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
            ),
          ) : Container()
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        controller: _scrollController,
        physics: status == Status.running ? AlwaysScrollableScrollPhysics() : NeverScrollableScrollPhysics(),
        child: Stack(
          children: <Widget>[
            Container(
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
            status == Status.none ? Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5
                ),
                child: Container(
                  color: Colors.black.withOpacity(0),
                ),
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }
}