import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seller_app/screens/OrderScreen/components/OrderCard.dart';

import '../../constaint.dart';

class TabBarOrder extends StatefulWidget {
  @override
  _TabBarOrderState createState() => _TabBarOrderState();
}

class _TabBarOrderState extends State<TabBarOrder> {


  @override
  Widget build(BuildContext context) {
    return TabBarView(
        children: [
          Column(
            children: [
              ListOrderItems(status: 'waiting', nextStepStatus: 'processing', denyStatus: 'denied', ),
            ] 
          ),
          Column(
            children: [
              ListOrderItems(status: 'processing', nextStepStatus: 'shipping'),
            ] 
          ),
          Column(
            children: [
              ListOrderItems(status: 'shipping', nextStepStatus: 'close',),
            ] 
          ),
          Column(
            children: [
              ListOrderItems(status: 'close',),
            ] 
          ),
          Column(
            children: [
              ListOrderItems(status: 'denied',),
            ] 
          ),
        ],
      );
  }
}

class ListOrderItems extends StatefulWidget {
  const ListOrderItems({
    this.status,
    Key key,
    this.nextStepStatus,
    this.denyStatus,
  }) : super(key: key);

  final String status, nextStepStatus, denyStatus;

  @override
  _ListOrderItemsState createState() => _ListOrderItemsState();
}

class _ListOrderItemsState extends State<ListOrderItems> {
  final dio = new Dio();
  List<dynamic> items = <dynamic>[];
  final sellerId = "6091721698d3fc0dd03d08a7";

  String status, nextStepStatus, denyStatus;

  @override
  void initState() {
    // TODO: implement initState
    status = widget.status;
    nextStepStatus = widget.nextStepStatus;
    denyStatus = widget.denyStatus;
    super.initState();
    dio.get('http://$ip:$api_port/order/item/$sellerId/$status').then((value) {
      if (value.data['success']) {
        if(mounted) {
          setState(() {
            items = value.data['items'];
          });
        } 
      }
    });
  }

  void _removeFormList(String orderItemId, String curentStatus) async {
    await dio.put('http://$ip:$api_port/order/updateOrderItemStatus/$orderItemId', data: {
      "status": curentStatus
    });
    dio.get('http://$ip:$api_port/order/item/$sellerId/$status').then((value) {
        if (value.data['success']) {
          if(mounted) {
            setState(() {
              items = value.data['items'];
            });
          } 
        }
      });
  }
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: items.length,
        itemBuilder: (context, index) {
          dynamic item = items[index];
          String productName = item['productId']['productName'];
          String orderItemId = item['_id'];
          String thumbnail = item['productId']['thumbnail'];
          int price = item['productId']['price'];
          int amount = item['amount'];
          final dateString = item['created'] != null ? item['created'] : DateTime.now().toString();
          String date = new DateFormat('dd-MM-yyyy').format(DateTime.parse(dateString)).toString();
          return OrderCard(
            orderItemId: orderItemId,
            productName: productName, 
            price: price, 
            amount: amount, 
            thumbnail: thumbnail,
            date: date,
            updateStatusAction: _removeFormList,
            nextStepStatus: nextStepStatus,
            denyStatus: denyStatus,
            currentStatus: status
          );
        },
      ),
    );
  }
}