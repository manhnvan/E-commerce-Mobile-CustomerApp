import 'package:flutter/material.dart';
import 'package:seller_app/abstracts/colors.dart';
import 'package:seller_app/abstracts/variables.dart';

// ignore: must_be_immutable
class ImageSelector extends StatelessWidget {
  Function getAsset;

  ImageSelector(this.getAsset);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.getAsset,
      child: Container(
        padding: const EdgeInsets.all(space_tiny),
        height: MediaQuery.of(context).size.width * 0.4,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(space_small)),
          border:
              Border.all(width: space_tiny - 2, color: color_primary_darker),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: color_gradient_primary,
            borderRadius: BorderRadius.all(Radius.circular(space_small - 2)),
          ),
          child: Center(
            child: Icon(Icons.add_a_photo_rounded,
                color: color_white, size: 30),
          ),
        ),
      ),
    );
  }
}
