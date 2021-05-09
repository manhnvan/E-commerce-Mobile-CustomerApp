import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:seller_app/screens/HomeScreen/ProductDetail.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    Key key,
    this.productName,
    this.image,
    this.price,
    this.vendor
  }) : super(key: key);

  String productName, image, vendor;
  int price;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: Card(
          child: Hero(
            tag:"Áo thun",
            child: Material(
              child: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, ProductDetail.routeName);
                },
                child: Container(
                  width: 400.0,
                  height: 400.0,
                  child: GridTile(

                    child: Image(
                      image: NetworkImage("https://namlongfashion.com/wp-content/uploads/2020/03/125.jpg"),
                      fit: BoxFit.cover,
                    ),
                    footer: Slidable(
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
                                icon: Icon(Icons.border_color, size: 35,),
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
                              child: IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.delete, size: 35,),
                              ),
                            ),
                          ),
                        ),
                      ],
                      child: GridTileBar(
                        backgroundColor: Colors.white70,
                        leading: Text("Áo thun", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                        title: Text("300.000", style:TextStyle(fontWeight: FontWeight.bold, color: Colors.black), ),
                        subtitle:Text("No brand", style:TextStyle(fontWeight: FontWeight.bold, color: Colors.black),) ,
                        trailing: Icon(Icons.arrow_back_ios, size: 35,color: Colors.grey,),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }
}
