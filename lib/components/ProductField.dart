import 'package:flutter/material.dart';
import 'package:seller_app/abstracts/colors.dart';
import 'package:seller_app/abstracts/variables.dart';

// ignore: must_be_immutable
class ProductField extends StatelessWidget {
  String productName;
  var controller;
  TextInputType keyboardType;

  ProductField(
      this.productName, this.controller, this.keyboardType);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(this.productName, style: Theme.of(context).textTheme.bodyText1),
        SizedBox(height: space_small),
        TextFormField(
            controller: this.controller,
            keyboardType: this.keyboardType,
            autofocus: false,
            maxLines: null,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(border_radius_big),
                borderSide: BorderSide(color: color_primary_darker, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(border_radius_big),
                borderSide: BorderSide(
                  color: color_secondary,
                  width: 1.5,
                ),
              ),
            )),
        SizedBox(height: space_big)
      ],
    );
  }
}
