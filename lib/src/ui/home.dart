import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              height: 250,
            ),
            clipper: BottomWaveClipper(),
          ),
          Positioned(
            top: 10,
            right: -10,
            child: Opacity(
              child: Image.asset('assets/airplane.png', height: 250,),
              opacity: 0.3,
            ),
          ),
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
                    child: ConstrainedBox(
                      child: Text(
                        "Selamat Datang",
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
                      childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height * (2 / 3)),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: <Widget>[
                        new GridItem(name: 'Tes Kecepatan Membaca', image: 'assets/airplane.png'),
                        new GridItem(name: 'hasil Tes', image: 'assets/hotel.png'),
                        new GridItem(name: 'Tentang Membaca Cepat', image: 'assets/bus.png'),
                        new GridItem(name: 'Cara Penggunaan', image: 'assets/sma.png'),
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
  final String name, image;
  const GridItem({
    @required this.name,
    @required this.image,
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
          onTap: () => Navigator.pushNamed(context, 'select-school'),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image.asset(image),
                ),
                SizedBox(height: 10,),
                Text(name, style: Theme.of(context).textTheme.button.copyWith(fontWeight: FontWeight.bold, color: Colors.blueGrey[700]),)
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
    path.lineTo(0.0, size.height - 30); 

    var firstControlPoint = Offset(size.width / 2, size.height + 20);
    var firstEndPoint = Offset(size.width, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}