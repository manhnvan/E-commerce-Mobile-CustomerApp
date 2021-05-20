import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../constaint.dart';

class OrderCard extends StatelessWidget {


  String productName, thumbnail, orderItemId, date, denyStatus, nextStepStatus, currentStatus;
  int amount, price;
  Function updateStatusAction;

  OrderCard({
    Key key,
    this.productName, 
    this.amount, 
    this.price, 
    this.date,
    this.thumbnail,
    this.orderItemId,
    this.updateStatusAction,
    this.nextStepStatus,
    this.denyStatus,
    this.currentStatus
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: [
        if (nextStepStatus != null) 
          GestureDetector (
            onTap: () {
              updateStatusAction(orderItemId, nextStepStatus);
            },
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
        if (denyStatus != null)
          GestureDetector(
            onTap: () {
              updateStatusAction(orderItemId, denyStatus);
            },
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
                      image: NetworkImage('$api_url/uploads/$thumbnail'),
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
                          productName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "số lượng: $amount",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          )
                        ),
                        Text(
                          "Đơn giá: $price",
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
                      date,
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