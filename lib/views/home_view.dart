import 'package:flutter/material.dart';
import 'package:sqa/entities/sqa_event.dart';
import 'package:sqa/model/event_dao.dart';
import 'package:sqa/themes/sqa_spacing.dart';
import 'package:sqa/themes/sqa_theme.dart';
import 'package:sqa/widgets/event_quick_info.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String user = "RBRNS";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/createEvent');
        },
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: createHelloUser(),
          ),
          SliverToBoxAdapter(
            child: createEventSchedule(),
          ),
          SliverToBoxAdapter(
            child: createCheckoutEvents(),
          ),
          SliverToBoxAdapter(
            child: createJoinSquad(),
          )
        ],
      ),
    );
  }

  Widget createHelloUser() {
    return Container(
      margin: const EdgeInsets.all(SqaSpacing.mediumMargin),
      child: Text(
        "Hello $user!",
        style: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: SqaTheme.fontColor,
            ),
      ),
    );
  }

  Widget createEventSchedule() {
    return Container(
      margin: const EdgeInsets.all(SqaSpacing.mediumMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My event schedule",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: SqaTheme.fontColor,
                ),
          ),
          const SizedBox(
            height: SqaSpacing.mediumMargin,
          ),
          createEventScheduleList()
        ],
      ),
    );
  }

  Widget createEventScheduleList() {
    List<SqaEvent> events = EventDao().getUpcomingEvents();
    List<Widget> eventItems = [];

    for (SqaEvent event in events) {
      if (eventItems.length < 5) {
        eventItems.add(
          EventQuickInfo(
            sqaEvent: event,
          ),
        );
      }
    }

    if (events.length > 5) {
      eventItems.add(SizedBox(
        width: 100,
        child: TextButton(onPressed: () {}, child: const Text("More Events")),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: eventItems,
    );
  }

  Widget createCheckoutEvents() {
    return Container(
      margin: const EdgeInsets.all(SqaSpacing.mediumMargin),
      height: 50,
      child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/event');
          },
          child: const Text("Upcoming Events")),
    );
  }

  Widget createJoinSquad() {
    return Container(
      margin: SqaSpacing.mediumHorizontalPadding,
      height: 50,
      child: FilledButton(onPressed: () {}, child: const Text("Join Squad")),
    );
  }
}
