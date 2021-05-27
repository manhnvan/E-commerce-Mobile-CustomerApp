import 'package:flutter/material.dart';
import 'package:seller_app/abstracts/colors.dart';
import 'package:seller_app/abstracts/variables.dart';

// ignore: must_be_immutable
class ImagePreviewer extends StatelessWidget {
  var image;

  ImagePreviewer(this.image);

  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.4,
        padding: const EdgeInsets.all(space_tiny),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(space_small)),
          border:
          Border.all(width: space_tiny - 2, color: color_primary_darker),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius:
              BorderRadius.all(Radius.circular(space_small - 2)),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover)),
        ));
  }
}