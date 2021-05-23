import 'package:carousel_pro/carousel_pro.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:seller_app/abstracts/colors.dart';
import 'package:seller_app/abstracts/variables.dart';
import 'package:seller_app/screens/UpdateProductScreen/UpdateProductScreen.dart';

import '../../constaint.dart';

// ignore: must_be_immutable
class ProductDetail extends StatefulWidget {
  static final routeName = '/productDetail';

  var currencyFormatter = new NumberFormat.simpleCurrency(
      locale: "vi_VN", name: "", decimalDigits: 0);

  ProductDetail({
    Key key,
  }) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String productName, vendor, description;
  List<dynamic> productImages = [
        'https://i0.wp.com/lucloi.vn/wp-content/uploads/2020/04/f45.jpg?fit=800%2C403&ssl=1'
      ],
      categories = [];

  double rating, like, price;

  dynamic product;

  String productId;

  var dio = new Dio();

  @override
  void initState() {
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
    Widget imageCarousel = new Container(
      height: 340.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: productImages.map((e) => NetworkImage(e.toString())).toList(),
        autoplay: false,
        dotSize: space_tiny,
        dotSpacing: space_medium,
        dotColor: color_green_dark,
        dotBgColor: color_primary_opacity_medium,
        indicatorBgPadding: space_medium,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        autoplayDuration: Duration(microseconds: 1000),
      ),
    );

    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text("Chi tiết sản phẩm"),
        gradient: color_gradient_primary,
        actions: [
          //Edit functionality here :v
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, UpdateProductScreen.routeName,
                  arguments: product);
            },
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.edit,
              ),
            ),
          ),

          //Delete functionality here :v
          GestureDetector(
            onTap: () {
              print('tapping delete');
            },
            child: Container(
                padding: EdgeInsets.only(right: 10), child: Icon(Icons.delete)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Images carousel here :)
            imageCarousel,

            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: space_huge, horizontal: space_medium),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Product's name here :>
                      Text('$productName',
                          style: Theme.of(context).textTheme.headline5),

                      SizedBox(height: space_medium),

                      //Product's vendor here :v
                      Text('Nhà sản xuất: $vendor',
                          style: Theme.of(context).textTheme.headline6),

                      SizedBox(height: space_small),

                      //Product's categories here :)
                      Wrap(
                        children: categories
                            .map((category) => Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: space_small,
                                      horizontal: space_medium),
                                  margin: EdgeInsets.only(
                                      right: space_small, bottom: space_small),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1000),
                                      gradient: color_gradient_dark),
                                  child: Text(
                                    category,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                            color: color_white, fontSize: 15),
                                  ),
                                ))
                            .toList(),
                      )
                    ])),

            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: space_big, horizontal: space_medium),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Price panel here :<
                    Transform.translate(
                      offset: Offset(-space_medium, 0),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(space_medium, space_medium,
                            space_big, space_medium),
                        decoration: BoxDecoration(
                            gradient: color_gradient_dark,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(border_radius_huge),
                                bottomRight:
                                    Radius.circular(border_radius_huge)),
                            boxShadow: [box_shadow_black]),
                        child: Text(
                          widget.currencyFormatter.format(price) + "đ",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: color_white),
                        ),
                      ),
                    ),

                    //This column contains number of ratings and likes~~
                    Column(
                      children: [
                        //Number of ratings~~
                        Container(
                          child: Row(
                            children: [
                              //Rating icon~~
                              Container(
                                margin: EdgeInsets.only(right: space_small),
                                child: Icon(Icons.stars_rounded,
                                    color: color_green_dark),
                              ),

                              //Rating text~~
                              Text('$rating',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(fontSize: 20))
                            ],
                          ),
                        ),

                        SizedBox(height: space_small),

                        //Number of likes~~
                        Container(
                          child: Row(
                            children: [
                              //Like icon here~~
                              Container(
                                margin: EdgeInsets.only(right: space_small),
                                child: Icon(
                                  Icons.favorite_outline_rounded,
                                  color: color_green_dark,
                                ),
                              ),

                              //Like text here~~
                              Text(
                                '$like',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontSize: 20),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )),

            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: space_big, horizontal: space_medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mô tả sản phẩm",
                    style: Theme.of(context).textTheme.headline5
                  ),

                  SizedBox(height: space_medium),

                  Text(
                    '$description',
                    style: Theme.of(context).textTheme.bodyText1
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