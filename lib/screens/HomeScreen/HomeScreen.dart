import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:seller_app/abstracts/colors.dart';
import 'package:seller_app/abstracts/variables.dart';
import 'package:seller_app/components/BottomNavBarVer2.dart';
import 'package:seller_app/constaint.dart';
import 'package:seller_app/screens/HomeScreen/components/ProductCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentUserId;
  SharedPreferences prefs;
  var dio = new Dio();
  List<dynamic> products = [];
  int page = 0;
  int limit = 10;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      currentUserId = prefs.getString('sellerId');
      dio
          .get(
              '$api_url/product?page=$page&limit=$limit&sellerId=$currentUserId')
          .then((value) {
        if (value.data['success']) {
          setState(() {
            products = value.data['docs'];
          });
        } else {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(value.data['msg']),
                  ));
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
          title: Text("Gian hàng của bạn",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: color_white)),
          gradient: color_gradient_primary,
          automaticallyImplyLeading: false),
      body: Container(
        color: color_grey,
        child: Stack(children: [
          ListView.builder(
            padding: EdgeInsets.only(
                left: space_small,
                right: space_small,
                top: space_small,
                bottom: nav_height),
            itemCount: products.length,
            itemBuilder: (context, index) {
              dynamic item = products[index];
              return ProductCard(
                  productId: item['_id'],
                  productName: item['productName'],
                  image: item['thumbnail'],
                  price: item['price'],
                  vendor: item['vendor'],
                  rate: item['rating'].toDouble(),
                  like: item['like'],
                  product: item);
            },
          ),
          Positioned(left: 0, bottom: 0, child: BottomNavBarVer2(0, null))
        ]),
      ),
      // bottomNavigationBar: BottomNavBar(0)
    );
  }
}
