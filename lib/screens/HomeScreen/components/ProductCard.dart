import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:seller_app/screens/HomeScreen/ProductDetail.dart';
import 'package:seller_app/screens/UpdateProductScreen/UpdateProductScreen.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    Key key,
    this.productName,
    this.image,
    this.price,
    this.vendor,
    this.sold,
    this.rate
  }) : super(key: key);

  String productName, image, vendor;
  int price, sold;
  double rate;

  @override
  Widget build(BuildContext context) {
    // return Slidable(
    //   child: Card(
    //       child: Hero(
    //         tag:"Áo thun",
    //         child: Material(
    //           child: InkWell(
    //             onTap: (){
    //               Navigator.pushNamed(context, ProductDetail.routeName);
    //             },
    //             child: Container(
    //               width: 400.0,
    //               height: 400.0,
    //               child: GridTile(
    //
    //                 child: Image(
    //                   image: NetworkImage("https://namlongfashion.com/wp-content/uploads/2020/03/125.jpg"),
    //                   fit: BoxFit.cover,
    //                 ),
    //                 footer: Slidable(
    //                   actionPane: SlidableDrawerActionPane(),
    //                   actionExtentRatio: 0.25,
    //                   secondaryActions: [
    //                     Positioned.fill(
    //                       child: Container(
    //                         margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    //                         constraints: BoxConstraints.expand(),
    //                         decoration: BoxDecoration(
    //                             color: Color.fromRGBO(46, 204, 113, 0.5),
    //                             borderRadius: BorderRadius.circular(20)
    //                         ),
    //                         child: Container(
    //                           child: IconButton(
    //                             onPressed: (){
    //                               Navigator.pushNamed(context, UpdateProductScreen.routeName);
    //                             },
    //                             icon: Icon(Icons.border_color, size: 35,),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     Positioned.fill(
    //                       child: Container(
    //                         margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    //                         constraints: BoxConstraints.expand(),
    //                         decoration: BoxDecoration(
    //                             color: Color.fromRGBO(231, 76, 60, 0.5),
    //                             borderRadius: BorderRadius.circular(20)
    //                         ),
    //                         child: Container(
    //                           child: IconButton(
    //                             onPressed: (){},
    //                             icon: Icon(Icons.delete, size: 35,),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                   child: GridTileBar(
    //                     backgroundColor: Colors.white70,
    //                     leading: Column(
    //                       children: [
    //                         Text("Áo thun", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),),
    //                         Text("300.000", style:TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20), ),
    //                       ],
    //                     ),
    //                     title: Text("300.000", style:TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20), ),
    //                     subtitle:Text("No brand", style:TextStyle(fontWeight: FontWeight.bold, color: Colors.black),) ,
    //                     trailing: Icon(Icons.arrow_back_ios, size: 35,color: Colors.grey,),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       )
    //   ),
    // );
    return Card(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        secondaryActions: [
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(46, 204, 113, 0.5),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Container(
                child: IconButton(
                  onPressed: (){
                  Navigator.pushNamed(context, UpdateProductScreen.routeName);
                },
                  icon:Icon(Icons.border_color,size: 35,)
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(231, 76, 60, 0.5),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Container(
                child: Icon(
                  Icons.delete,
                  size: 35,
                ),
              ),
            ),
          ),
        ],
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context, ProductDetail.routeName);
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
                      // Container(
                      //   width: 80,
                      //   height: 80,
                      //   decoration: BoxDecoration(
                      //       shape: BoxShape.rectangle,
                      //       image: DecorationImage(
                      //           image: NetworkImage("https://namlongfashion.com/wp-content/uploads/2020/03/125.jpg"),
                      //           fit: BoxFit.fill
                      //       )
                      //   ),
                      // ),
                      Container(
                        width: 100,
                        height: 100,
                        child: Image(
                            image: NetworkImage("https://namlongfashion.com/wp-content/uploads/2020/03/125.jpg"),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Áo phông mùa hè",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                  "Giá: 150.000 đ",
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
                                  Text("106", style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal) ,)
                                ],
                              ),
                            ),
                            Text(
                              "Đã bán:69",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ]
                      )
                    ]
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
