import 'package:flutter/widgets.dart';

class SqaSpacing {
  // Margins
  static const smallMargin = 5.0;
  static const mediumMargin = 10.0;
  static const largeMargin = 20.0;

  // Padding
  static const smallPadding = 5.0;
  static const mediumPadding = 10.0;
  static const largePadding = 20.0;

  static const EdgeInsets nonePaddingInsets = EdgeInsets.all(0);
  static const EdgeInsets noneMarginInsets = EdgeInsets.all(0);

  static const EdgeInsets smallMarginEdgeInsets = EdgeInsets.all(smallMargin);
  static const EdgeInsets mediumMarginEdgeInsets = EdgeInsets.all(mediumMargin);
  static const EdgeInsets largeMarginEdgeInsets = EdgeInsets.all(largeMargin);

  static const EdgeInsets smallPaddingEdgeInsets = EdgeInsets.all(smallPadding);
  static const EdgeInsets mediumPaddingEdgeInsets =
      EdgeInsets.all(mediumPadding);
  static const EdgeInsets largePaddingEdgeInsets = EdgeInsets.all(largePadding);

  static const EdgeInsets smallHorizontalPadding =
      EdgeInsets.symmetric(horizontal: smallPadding);
  static const EdgeInsets mediumHorizontalPadding =
      EdgeInsets.symmetric(horizontal: mediumPadding);
  static const EdgeInsets largeHorizontalPadding =
      EdgeInsets.symmetric(horizontal: largePadding);

  static const EdgeInsets smallVerticalPadding =
      EdgeInsets.symmetric(vertical: smallPadding);
  static const EdgeInsets mediumVerticalPadding =
      EdgeInsets.symmetric(vertical: mediumPadding);
  static const EdgeInsets largeVerticalPadding =
      EdgeInsets.symmetric(vertical: largePadding);
}
