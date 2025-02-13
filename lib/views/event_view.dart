import 'package:flutter/material.dart';
import 'package:sqa/entities/sport_type.dart';
import 'package:sqa/model/sports_dao.dart';
import 'package:sqa/themes/sqa_spacing.dart';
import 'package:sqa/themes/sqa_theme.dart';
import 'package:sqa/widgets/sports_type_category.dart';

class EventView extends StatefulWidget {
  const EventView({super.key});

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    List<SportType> sportTypeCategories = SportsDao().getSportsTypes();

    if (searchString != "") {
      sportTypeCategories = sportTypeCategories
          .where((sportType) => sportType.name.contains(searchString))
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Upcoming events"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/joinEventByQR');
              },
              icon: const Icon(Icons.qr_code))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: createSportsCategorySearchField(),
          ),
          SliverList.builder(
            itemCount: sportTypeCategories.length,
            itemBuilder: (context, index) {
              return SportsTypeCategory(
                sportType: sportTypeCategories[index],
              );
            },
          )
        ],
      ),
    );
  }

  Widget createSportsCategorySearchField() {
    return Container(
      margin: SqaSpacing.mediumMarginEdgeInsets,
      child: SearchBar(
        hintText: "Search for sport..",
        onSubmitted: (value) {
          setState(() {
            searchString = value;
          });
        },
        leading: Icon(
          Icons.search,
          color: SqaTheme.secondaryColor,
        ),
      ),
    );
  }
}
