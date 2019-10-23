import 'package:flutter/material.dart';

class SelectSchool extends StatefulWidget {
  @override
  _SelectSchoolState createState() => _SelectSchoolState();
}

class _SelectSchoolState extends State<SelectSchool> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xFF03A9F4),
              ),
              height: 300,
              child: Opacity(
                opacity: 0.3,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Image.asset('assets/images/school.png', height: 250,),
                      bottom: 0,
                      right: -80,
                    )
                  ],
                )
              ),
            ),
            clipper: BottomWaveClipper(),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 60, left: 10, right: 10, bottom: 10),
                    child: ConstrainedBox(
                      child: Text(
                        "Pilih Jenjang Pendidikan",
                        textAlign: TextAlign.left,
                        style: textTheme.headline.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 200),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Expanded(
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: <Widget>[
                        new GridItem(name: 'SD/MI', image: 'assets/images/sd.png', type: 'sd'),
                        new GridItem(name: 'SMP/MTS', image: 'assets/images/smp.png', type: 'smp'),
                        new GridItem(name: 'SMA/MA', image: 'assets/images/sma.png', type: 'sma'),
                        new GridItem(name: 'MAHASISWA', image: 'assets/images/university.png', type: 'mahasiswa'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String name, image, type;
  const GridItem({
    @required this.name,
    @required this.image,
    @required this.type,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 6,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => Navigator.pushNamed(context, 'select-subject/$type'),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image.asset(image),
                ),
                SizedBox(height: 10,),
                Text(name, style: Theme.of(context).textTheme.subtitle.copyWith(fontWeight: FontWeight.bold, color: Colors.blueGrey[700]),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20); 

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}