import 'package:firebase_auth/firebase_auth.dart';
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
  String? user = "";

  late Future _loadEventSchedule;

  @override
  initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser?.displayName;

    if (user != null && user!.contains(" ")) {
      user = user!.split(" ").first;
    }

    _loadEventSchedule = _readEventSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
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
          Row(
            children: [
              Text(
                "My event schedule",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: SqaTheme.fontColor,
                    ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  _loadEventSchedule = _readEventSchedule();
                  setState(() {});
                },
                icon: const Icon(
                  Icons.refresh,
                ),
              )
            ],
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
    return FutureBuilder(
      future: _loadEventSchedule,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<SqaEvent>? events = snapshot.data;
          List<Widget> eventItems = [];

          if (events == null || events.isEmpty) {
            return Text(
              "No upcoming events",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: SqaTheme.subFontColor),
            );
          }

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
              child: TextButton(
                  onPressed: () {}, child: const Text("More Events")),
            ));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: eventItems,
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
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
        child: const Text("Explore Events"),
      ),
    );
  }

  Widget createJoinSquad() {
    return Container(
      margin: SqaSpacing.mediumHorizontalPadding,
      height: 50,
      child: FilledButton(
        onPressed: () {},
        child: const Text("Join Squad"),
      ),
    );
  }

  Future _readEventSchedule() async {
    List<SqaEvent>? userHasRegistered =
        await EventDao().getEventsUserHasRegistered();
    List<SqaEvent>? userHasCreated = await EventDao().getEventsCreatedByUser();

    if (userHasCreated == null && userHasRegistered == null) return null;

    List<SqaEvent> eventSchedule = [];

    if (userHasCreated != null) eventSchedule.addAll(userHasCreated);
    if (userHasRegistered != null) eventSchedule.addAll(userHasRegistered);

    return eventSchedule;
  }
}
