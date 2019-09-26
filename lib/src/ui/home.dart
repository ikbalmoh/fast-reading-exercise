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
              child: Opacity(
                opacity: 0.3,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Image.asset('assets/images/airplane.png', height: 250,),
                      top: -10,
                      right: -20,
                    )
                  ],
                )
              ),
            ),
            clipper: BottomWaveClipper(),
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
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * (3/4)),
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
                        new GridItem(name: 'Tes Kecepatan Membaca', image: 'assets/images/airplane.png', url: 'select-school',),
                        new GridItem(name: 'Hasil Tes', image: 'assets/images/hotel.png', url: 'about/about'),
                        new GridItem(name: 'Tentang Membaca Cepat', image: 'assets/images/bus.png', url: 'about/about'),
                        new GridItem(name: 'Cara Penggunaan', image: 'assets/images/sma.png', url: 'about/tutorial'),
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
  final String name, image, url;
  const GridItem({
    @required this.name,
    @required this.image,
    @required this.url,
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
          onTap: () => Navigator.pushNamed(context, url),
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