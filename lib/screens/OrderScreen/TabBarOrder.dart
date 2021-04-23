import 'package:flutter/material.dart';
import 'package:seller_app/screens/OrderScreen/components/OrderCard.dart';

class TabBarOrder extends StatelessWidget {
  const TabBarOrder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  children: [1,2,3,4,5,6,7].map((e) => OrderCard(productName: "Áo phông coolmate", price: 300000, amount: 3, date: "21/04/2021")).toList(),
                ),
              ),
            ] 
          ),
          Icon(Icons.directions_transit),
          Icon(Icons.directions_bike),
          Icon(Icons.directions_bike),
        ],
      );
  }
}