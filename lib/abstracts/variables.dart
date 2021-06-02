import 'package:flutter/cupertino.dart';

import 'colors.dart';

const double space_tiny = 4.0;
const double space_small = 8.0;
const double space_medium = 16.0;
const double space_big = 24.0;
const double space_huge = 32.0;

const double border_radius_small = 3.0;
const double border_radius_big = 20.0;
const double border_radius_huge = 60.0;

const double icon_size = 30.0;
const double nav_height = 80.0;

const BorderRadius card_shape_primary = BorderRadius.only(
  topLeft: Radius.circular(border_radius_small),
  topRight: Radius.circular(border_radius_big),
  bottomRight: Radius.circular(border_radius_small),
  bottomLeft: Radius.circular(border_radius_big),
);

const BorderRadius card_shape_secondary = BorderRadius.only(
  topLeft: Radius.circular(border_radius_huge),
  topRight: Radius.circular(border_radius_big),
  bottomRight: Radius.circular(border_radius_small),
  bottomLeft: Radius.circular(border_radius_huge),
);

const BoxShadow box_shadow_black = BoxShadow(
  color: color_black_opacity_strong,
  blurRadius: 4, // soften the shadow
  spreadRadius: -1.0, //extend the shadow
  offset: Offset(
    0.0,
    0.5,
  ),
);