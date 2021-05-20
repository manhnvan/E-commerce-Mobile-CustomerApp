import 'package:carousel_pro/carousel_pro.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/screens/UpdateProductScreen/UpdateProductScreen.dart';
import '../../constaint.dart';

class ProductDetail extends StatefulWidget {
  static final routeName = '/productDetail';
  ProductDetail({
    Key key,
  }) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  String productName, vendor, description;
  List<dynamic> productImages = ['https://i0.wp.com/lucloi.vn/wp-content/uploads/2020/04/f45.jpg?fit=800%2C403&ssl=1'], categories = [];

  double rating, like, price;

  dynamic product;

  String productId;

  var dio = new Dio();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      dynamic args = ModalRoute.of(context).settings.arguments;
      final id = args['productId'];
      dio.get('$api_url/product/$id').then((value) {
        if (value.data['success']) {
          final item = value.data['doc'];
          setState(() {
            product = item;
            productId = product['_id'];
            productName = product['productName'].toString();
            description = product['description'].toString();
            productImages = product['productImages'];
            vendor = product['vendor'].toString();
            categories = product['categories'];
            price = product['price'].toDouble();
            rating = product['rating'].toDouble();
            like = product['like'].toDouble();
          });
        }
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 300.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: productImages.map((e) => NetworkImage(e.toString())).toList(),
        autoplay: false,
        dotSize: 4.0,
        dotSpacing: 15.0,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        autoplayDuration: Duration(microseconds: 1000),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("Chi tiết sản phẩm"),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, UpdateProductScreen.routeName, arguments: product);
              },
              child: Container(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.edit,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('tapping delete');
              },
              child: Container(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.delete
                )
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              image_carousel,
              Divider(
                height: 25.0,
              ),
              Padding(
                  padding:EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0) ,
                  child: Column(
                    children: [
                      Text(
                        '$productName', 
                        style: TextStyle(
                          fontSize: 30.0, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        '$vendor', 
                        style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal)
                      ),
                      Wrap(
                        children: categories.map((e) => Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(192, 57, 43,1.0)
                          ),
                          child: Text(
                            e,
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        )).toList(),
                      )
                    ] 
                  )
              ),
              Padding(
                  padding:EdgeInsets.fromLTRB(20.0, 5.0, 80.0, 0.0) ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("$price đ", style:TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold) ,),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.orangeAccent,),
                            Text('$rating', style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal) ,)
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.favorite, color: Colors.red,),
                            Text('$like' , style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal) ,)
                          ],
                        ),
                      )
                    ],
                  )
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mô tả", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),),
                    Text('$description',
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }
}
