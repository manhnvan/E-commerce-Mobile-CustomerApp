import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OrderCard extends StatelessWidget {
  OrderCard({
    Key key,
    this.productName, 
    this.amount, 
    this.price, 
    this.date
  }) : super(key: key);

  String productName;
  int amount, price;
  String date;

  @override
  Widget build(BuildContext context) {
    return Slidable(
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
              child: Icon(
                Icons.check_box,
                size: 35,
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
      child: Container(
        padding: EdgeInsets.all(16),
        margin: new EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink, Colors.red],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)) 
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,   
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage("https://mcdn.coolmate.me/uploads/April2021/cs_dden_giua_nhe.jpg"),
                      fit: BoxFit.fill
                    )
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Áo phông coolmate",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "số lượng: 3",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          )
                        ),
                        Text(
                          "Đơn giá: 150.000 đ",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          )
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '20/2/2021',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ]
                )
              ]
            )
          ],
        ),
      ),
    );
  }
}