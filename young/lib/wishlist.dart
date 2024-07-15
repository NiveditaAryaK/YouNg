import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: Container(
        width: 430,
        height: 932,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Positioned(
              left: 66,
              top: 851,
              child: Container(
                width: 298,
                height: 62,
                decoration: ShapeDecoration(
                  color: Color(0xFF2D0B2D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 152,
              top: 857,
              child: Container(
                width: 51,
                height: 51,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 93,
              top: 870,
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/25x25"),
                    fit: BoxFit.fill,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 240,
              top: 868,
              child: Container(
                width: 25,
                height: 26,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/25x26"),
                    fit: BoxFit.fill,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 308,
              top: 866,
              child: Container(
                width: 30,
                height: 29,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/30x29"),
                    fit: BoxFit.fill,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 167,
              top: 872,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/22x22"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 136,
              child: Container(
                width: 200,
                height: 280,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/200x280"),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 27,
              top: 96,
              child: Container(
                width: 375,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFF2D0B2D),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 171,
              top: 31,
              child: Text(
                'Wishlist',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'Josefin Sans',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 36,
              top: 71,
              child: Text(
                '1 item',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Josefin Sans',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 267,
              top: 76,
              child: Text(
                'Sort By : Recently Added',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Josefin Sans',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 220,
              top: 136,
              child: Container(
                width: 200,
                height: 280,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/200x280"),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
