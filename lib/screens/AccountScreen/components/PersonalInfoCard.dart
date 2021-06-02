import 'package:flutter/material.dart';
import 'package:seller_app/abstracts/colors.dart';
import 'package:seller_app/abstracts/variables.dart';

// ignore: must_be_immutable
class PersonalInfoCard extends StatelessWidget {
  IconData icon;
  String label;
  var info;

  PersonalInfoCard(this.icon, this.label, this.info);

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
              children: [
                Icon(this.icon, size: icon_size),
                SizedBox(width: space_small),
                Text(this.label,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1)
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: EdgeInsets.all(space_medium),
          decoration: BoxDecoration(
            color: color_white,
            boxShadow: [box_shadow_black],
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(border_radius_big))
          ),
          child: Text(this.info,
              style: Theme.of(context).textTheme.bodyText1),
        ),
        SizedBox(height: space_medium)
      ],
    );
  }
}
