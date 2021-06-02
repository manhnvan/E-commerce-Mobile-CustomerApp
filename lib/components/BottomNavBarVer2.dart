import 'package:flutter/material.dart';
import 'package:seller_app/abstracts/colors.dart';
import 'package:seller_app/abstracts/variables.dart';
import 'package:seller_app/screens/AccountScreen/AccountScreen.dart';
import 'package:seller_app/screens/AddProductScreen/AddProductScreen.dart';
import 'package:seller_app/screens/ChatScreen/ChatScreen.dart';
import 'package:seller_app/screens/HomeScreen/HomeScreen.dart';
import 'package:seller_app/screens/OrderScreen/OrderScreen.dart';

// ignore: must_be_immutable
class BottomNavBarVer2 extends StatelessWidget {
  int index;
  Function uploadProduct;

  BottomNavBarVer2(this.index, this.uploadProduct);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: nav_height,
      child: Stack(children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, nav_height),
          painter: EZCustomPainter(),
        ),
        Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
                elevation: space_small,
                onPressed: () {
                  index == 2
                      ? this.uploadProduct()
                      : Navigator.pushNamed(
                          context, AddProductScreen.routeName);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, gradient: color_gradient_primary),
                  child: Icon(
                      index == 2
                          ? Icons.upload_rounded
                          : Icons.add_circle_rounded,
                      size: icon_size,
                      color: color_white),
                ))),
        Container(
            width: MediaQuery.of(context).size.width,
            height: nav_height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    icon: Icon(Icons.home_rounded,
                        size: icon_size,
                        color: index == 0 ? color_secondary : color_green_dark),
                    onPressed: () {
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    }),
                IconButton(
                    icon: Icon(Icons.list_alt_rounded,
                        size: icon_size,
                        color: index == 1 ? color_secondary : color_green_dark),
                    onPressed: () {
                      Navigator.pushNamed(context, OrderScreen.routeName);
                    }),
                SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                IconButton(
                    icon: Icon(Icons.message_rounded,
                        size: icon_size,
                        color: index == 3 ? color_secondary : color_green_dark),
                    onPressed: () {
                      Navigator.pushNamed(context, ChatScreen.routeName);
                    }),
                IconButton(
                    icon: Icon(Icons.account_circle_rounded,
                        size: icon_size,
                        color: index == 4 ? color_secondary : color_green_dark),
                    onPressed: () {
                      Navigator.pushNamed(context, AccountScreen.routeName);
                    })
              ],
            ))
      ]),
    );
  }
}

class EZCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color_white
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.2, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.4, 0, size.width * 0.4, 20);
    path.arcToPoint(Offset(size.width * 0.6, 20),
        radius: Radius.circular(space_small), clockwise: false);
    path.quadraticBezierTo(size.width * 0.6, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.8, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, color_black, 25, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
