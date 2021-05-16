import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:seller_app/components/BottomNavBar.dart';
import 'package:seller_app/screens/HomeScreen/components/ProductCard.dart';
import '../../constaint.dart';

class HomeScreen extends StatelessWidget {
  static final routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Gian hàng", textAlign: TextAlign.center,),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("Các sản phẩm có trong cửa hàng", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProductCard(),
                  ProductCard(),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar:BottomNavBar(0)
    );
  }
}
