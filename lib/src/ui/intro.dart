import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {

  final pages = [
    PageViewModel(
      pageColor: const Color(0xFF03A9F4),
      body: Text(
        'Haselfree  booking  of  flight  tickets  with  full  refund  on  cancelation',
      ),
      title: Text(
        'Flights',
      ),
      textStyle: TextStyle(color: Colors.white),
      mainImage: Image.asset(
        'assets/images/airplane.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )
    ),
    PageViewModel(
      pageColor: const Color(0xFF03A9F4),
      body: Text(
        'We  work  for  the  comfort ,  enjoy  your  stay  at  our  beautiful  hotels',
      ),
      title: Text('Hotels'),
      mainImage: Image.asset(
        'assets/images/hotel.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(color: Colors.white),
    ),
    PageViewModel(
      pageColor: const Color(0xFF03A9F4),
      body: Text(
        'Easy  cab  booking  at  your  doorstep  with  cashless  payment  system',
      ),
      title: Text('Cabs'),
      mainImage: Image.asset(
        'assets/images/taxi.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(color: Colors.white),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      pages,
      onTapDoneButton: () => Navigator.pushReplacementNamed(context, 'home'),
      pageButtonTextStyles: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
      doneText: Text('OK'),
      skipText: Text('LEWAT'),
    );
  }
}