import 'package:flutter/material.dart';
import 'package:sqa/entities/sqa_event.dart';
import 'package:sqa/model/event_dao.dart';

class ExploreEventsView extends StatefulWidget {
  final String sportsType;
  const ExploreEventsView({super.key, required this.sportsType});

  @override
  State<ExploreEventsView> createState() => _ExploreEventsViewState();
}

class _ExploreEventsViewState extends State<ExploreEventsView> {
  late Future<List<SqaEvent>?> _loadUpcomingEvents;

  @override
  initState() {
    super.initState();
    _loadUpcomingEvents = EventDao().getUpcomingEvents(widget.sportsType);
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: _loadUpcomingEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<SqaEvent> events = snapshot.data!;
              return _showEventsList(events);
            }
            return const Center(
              child: Text("No upcoming events... :("),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _showEventsList(List<SqaEvent> events) {
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            return Container();
          },
        )
      ],
    );
  }
}
