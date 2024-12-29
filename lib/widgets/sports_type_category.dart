import 'package:flutter/material.dart';
import 'package:sqa/entities/sport_type.dart';
import 'package:sqa/themes/sqa_spacing.dart';
import 'package:sqa/themes/sqa_theme.dart';

class SportsTypeCategory extends StatefulWidget {
  final SportType sportType;
  const SportsTypeCategory({super.key, required this.sportType});

  @override
  State<SportsTypeCategory> createState() => _SportsTypeCategoryState();
}

class _SportsTypeCategoryState extends State<SportsTypeCategory> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: SqaSpacing.mediumHorizontalPadding.copyWith(
            bottom: SqaSpacing.smallMargin, top: SqaSpacing.smallMargin),
        padding: SqaSpacing.mediumPaddingEdgeInsets,
        color: SqaTheme.secondaryColor,
        height: 100,
        child: Row(
          children: [
            Icon(
              widget.sportType.icon,
              size: 50,
              color: SqaTheme.backgroundColor,
            ),
            const SizedBox(
              width: SqaSpacing.mediumMargin,
            ),
            Text(
              widget.sportType.name,
              style: Theme.of(context).textTheme.displaySmall,
            )
          ],
        ),
      ),
    );
  }
}
