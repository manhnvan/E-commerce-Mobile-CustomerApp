import 'package:flutter/material.dart';
import 'package:seller_app/abstracts/colors.dart';
import 'package:seller_app/abstracts/variables.dart';

// ignore: must_be_immutable
class OrderInfoCard extends StatelessWidget {
  IconData icon;
  String label;
  var info;

  OrderInfoCard(this.icon, this.label, this.info);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(1.5),
          decoration: BoxDecoration(
              borderRadius: card_shape_primary,
              gradient: color_gradient_secondary,
              boxShadow: [box_shadow_black]),
          child: Container(
            padding: EdgeInsets.all(space_medium),
            decoration: BoxDecoration(
                borderRadius: card_shape_primary,
                color: color_white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(this.icon, size: icon_size),
                    SizedBox(width: space_small),
                    Text(this.label,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1)
                  ],
                ),

                Text(this.info, style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
          ),
        ),
        SizedBox(height: space_medium)
      ],
    );
  }
}
