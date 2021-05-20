import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:seller_app/screens/HomeScreen/ProductDetail.dart';
import 'package:seller_app/screens/UpdateProductScreen/UpdateProductScreen.dart';

import '../../../constaint.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    Key key,
    this.productId,
    this.productName,
    this.image,
    this.price,
    this.vendor,
    this.sold,
    this.rate,
    this.like
  }) : super(key: key);

  String productName, image, vendor, productId;
  int price, sold;
  double rate;
  int like;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, ProductDetail.routeName, arguments: {
            "productId": productId
          });
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 0, 10 ,0),
          margin: new EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue, Colors.lightBlueAccent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight
              ),
              // borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Image(
                          image: NetworkImage(image),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                                "Giá: $price đ",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                )
                            ),

                          ],
                        ),
                      ),
                    ),
                    Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(Icons.favorite, color: Colors.red,),
                                Text("$like", style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal) ,)
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(Icons.star, color: Colors.yellow,),
                                Text("$rate", style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal) ,)
                              ],
                            ),
                          )
                        ]
                    )
                  ]
              )
            ],
          ),
        ),
      ),
    );
  }
}
