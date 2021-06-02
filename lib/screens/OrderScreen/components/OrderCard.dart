import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:seller_app/abstracts/colors.dart';
import 'package:seller_app/abstracts/variables.dart';

// ignore: must_be_immutable
class OrderCard extends StatelessWidget {
  var currencyFormatter = new NumberFormat.simpleCurrency(
      locale: "vi_VN", name: "", decimalDigits: 0);

  String productName,
      thumbnail,
      orderItemId,
      date,
      denyStatus,
      nextStepStatus,
      currentStatus;
  int amount, price;
  Function updateStatusAction;

  OrderCard(
      {Key key,
      this.productName,
      this.amount,
      this.price,
      this.date,
      this.thumbnail,
      this.orderItemId,
      this.updateStatusAction,
      this.nextStepStatus,
      this.denyStatus,
      this.currentStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: [
        if (nextStepStatus != null)
          GestureDetector(
            onTap: () {
              updateStatusAction(orderItemId, nextStepStatus);
            },
            child: Container(
              margin: EdgeInsets.only(
                  top: space_huge,
                  bottom: space_huge,
                  left: space_small,
                  right: space_tiny),
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                  color: color_white,
                  boxShadow: [box_shadow_black],
                  borderRadius: BorderRadius.circular(border_radius_big)),
              child: Container(
                child: Icon(
                  Icons.check_circle_rounded,
                  color: color_secondary,
                  size: icon_size,
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
              margin: EdgeInsets.only(
                  top: space_huge, bottom: space_huge, left: space_small),
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                  color: color_white,
                  boxShadow: [box_shadow_black],
                  borderRadius: BorderRadius.circular(border_radius_big)),
              child: Container(
                child: Icon(
                  Icons.delete_rounded,
                  color: color_red_light,
                  size: icon_size,
                ),
              ),
            ),
          ),
      ],
      child: Container(
        margin: EdgeInsets.symmetric(vertical: space_small),
        child: ClipRRect(
          borderRadius: card_shape_primary,
          clipBehavior: Clip.antiAlias,
          child: Container(
            padding: EdgeInsets.all(1.5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(border_radius_big)),
                gradient: color_gradient_secondary,
                boxShadow: [box_shadow_black]),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: card_shape_primary, color: color_white),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Card's thumbnail here ^^
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 125,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(thumbnail),
                                  fit: BoxFit.cover)),
                        ),

                        //Card's info here :)
                        Expanded(
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: space_medium),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Product's name here :v
                                Text(
                                  productName,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.bold),
                                ),

                                SizedBox(height: space_tiny),

                                //Product's quantity here :<
                                Text(
                                  "Số lượng: $amount",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(fontSize: 13.5),
                                ),

                                SizedBox(height: space_big),

                                //Product's date here :O
                                Text(
                                  // "Đơn giá: $price",
                                  date,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: color_black_opacity_strong,
                                          fontSize: 13.5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),

                //Price panel here :>
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: space_small, horizontal: space_medium),
                        decoration: BoxDecoration(
                            boxShadow: [box_shadow_black],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomRight: Radius.circular(3),
                                bottomLeft: Radius.circular(20)),
                            gradient: color_gradient_primary),
                        child: Text(currencyFormatter.format(price) + 'đ',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: color_white))))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
