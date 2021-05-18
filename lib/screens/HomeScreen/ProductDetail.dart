import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:seller_app/components/BottomNavBar.dart';
import 'package:seller_app/screens/HomeScreen/components/ProductCard.dart';
import '../../constaint.dart';

class ProductDetail extends StatelessWidget {
  static final routeName = '/productDetail';
  ProductDetail({
    Key key,
    this.productName,
    this.image,
    this.price,
    this.vendor,
    this.liked
  }) : super(key: key);

  String productName, vendor;
  List<String> image;
  int price, liked;

  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 300.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          NetworkImage("https://namlongfashion.com/wp-content/uploads/2020/03/125.jpg"),
          NetworkImage("https://vn-test-11.slatic.net/p/e6b84942b3e0b79f9ffde06848c23270.jpg"),
          NetworkImage("https://vn-test-11.slatic.net/p/e6b84942b3e0b79f9ffde06848c23270.jpg"),
        ],
        autoplay: false,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        autoplayDuration: Duration(microseconds: 1000),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("Chi tiết sản phẩm"),
        ),
        body: ListView(
          children: [
            image_carousel,
            Divider(
              height: 25.0,
            ),
            // productName
            Padding(
                padding:EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0) ,
                child: Text("Áo thun chất liệu cotton", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),)
            ),
            Padding(
                padding:EdgeInsets.fromLTRB(20.0, 5.0, 80.0, 0.0) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("300.000đ", style:TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold) ,),
                    // ElevatedButton.icon(
                    //     onPressed: (){},
                    //     label: Text("Đánh giá"),
                    //     icon: Icon(Icons.ac_unit)
                    // )
                    Container(
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.orangeAccent,),
                          Text("4.5/5(86)", style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal) ,)
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Icon(Icons.favorite, color: Colors.red,),
                          Text("106", style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal) ,)
                        ],
                      ),
                    )
                  ],
                )
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  Text("No brand", style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal) ,),
                  SizedBox(width: 30.0,),
                  // Text("300.000đ",style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal) , ),
                ], ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Chi tiết", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),),
                  Text("Áo chất liệu cotton. Thoáng mát dễ chịu. Có đủ màu, đủ size. Hình in trên áo không bị bong khi giặt bằng máy giặt, Áo không phai màu",
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0),
                  )
                ],
              ),
            )
          ],
        ),
        // bottomNavigationBar: BottomNavBar()
    );
  }
}
