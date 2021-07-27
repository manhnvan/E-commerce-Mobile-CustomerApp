import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:seller_app/abstracts/variables.dart';
import 'package:seller_app/screens/OrderScreen/components/OrderCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        Column(children: [
          ListOrderItems(
            status: 'waiting',
            nextStepStatus: 'processing',
            denyStatus: 'denied',
          ),
        ]),
        Column(children: [
          ListOrderItems(status: 'processing', nextStepStatus: 'shipping'),
        ]),
        Column(children: [
          ListOrderItems(
            status: 'shipping',
            nextStepStatus: 'close',
          ),
        ]),
        Column(children: [
          ListOrderItems(
            status: 'close',
          ),
        ]),
        Column(children: [
          ListOrderItems(
            status: 'denied',
          ),
        ]),
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
  SharedPreferences prefs;

  String status, nextStepStatus, denyStatus;
  String sellerId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      sellerId = prefs.getString('sellerId');
      status = widget.status;
      nextStepStatus = widget.nextStepStatus;
      denyStatus = widget.denyStatus;
      EasyLoading.show(status: 'Loading ...');

      dio.get('$api_url/order/item/seller/$sellerId/$status').then((value) {
        if (value.data['success']) {
          if (mounted) {
            setState(() {
              items = value.data['items'];
            });
          }
        }
        EasyLoading.dismiss();
      }).catchError((error) {
        EasyLoading.dismiss();
      });
    });
  }

  void _removeFormList(String orderItemId, String curentStatus) async {
    await dio.put('$api_url/order/updateOrderItemStatus/$orderItemId',
        data: {"status": curentStatus});
    dio.get('$api_url/order/item/seller/$sellerId/$status').then((value) {
      print(value.data);
      if (value.data['success']) {
        if (mounted) {
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
        padding: EdgeInsets.only(
            left: space_small, right: space_small, top: space_medium, bottom: nav_height),
        itemCount: items.length,
        itemBuilder: (context, index) {
          dynamic item = items[index];
          String productName = item['productId']['productName'];
          String orderItemId = item['_id'];
          String thumbnail = item['productId']['thumbnail'];
          int price = item['productId']['price'];
          int amount = item['amount'];
          final dateString = item['created'] != null
              ? item['created']
              : DateTime.now().toString();
          String date = new DateFormat('dd-MM-yyyy')
              .format(DateTime.parse(dateString))
              .toString();
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
              currentStatus: status);
        },
      ),
    );
  }
}
