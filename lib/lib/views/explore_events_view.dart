import 'package:flutter/material.dart';
import 'package:sqa/entities/sqa_event.dart';
import 'package:sqa/model/event_dao.dart';
import 'package:sqa/themes/sqa_theme.dart';
import 'package:sqa/widgets/event_filter_dialog_widget.dart';
import 'package:sqa/widgets/event_info_widget.dart';

class ExploreEventsView extends StatefulWidget {
  final String sportsType;
  const ExploreEventsView({super.key, required this.sportsType});

  @override
  State<ExploreEventsView> createState() => _ExploreEventsViewState();
}

class _ExploreEventsViewState extends State<ExploreEventsView> {
  late Future<List<SqaEvent>?> _loadUpcomingEvents;
  bool noEvents = false;

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
      floatingActionButton: noEvents
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                _showFilterDialog();
              },
              child: const Icon(Icons.filter_list),
            ),
      body: FutureBuilder(
        future: _loadUpcomingEvents,
        builder: (context, snapshot) {
          Widget contentWidget = const Center(
            child: CircularProgressIndicator(),
          );

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<SqaEvent> events = snapshot.data!;
              contentWidget = _showEventsList(events);
            } else {
              noEvents = true;
              contentWidget = const Center(
                child: Text("No upcoming events... :("),
              );
            }
          }

          return RefreshIndicator(
            color: SqaTheme.primaryColor,
            child: contentWidget,
            onRefresh: () async {
              noEvents = false;
              setState(() {});
            },
          );
        },
      ),
    );
  }

  Widget _showEventsList(List<SqaEvent> events) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return EventInfoWidget(
          sqaEvent: events[index],
        );
      },
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const EventFilterDialogWidget();
      },
    );
  }
}
