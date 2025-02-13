import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sqa/entities/sqa_event.dart';
import 'package:sqa/model/event_dao.dart';
import 'package:sqa/model/users_dao.dart';
import 'package:sqa/themes/sqa_spacing.dart';
import 'package:sqa/themes/sqa_theme.dart';
import 'package:sqa/utils/helper.dart';
import 'package:sqa/widgets/event_count_down_widget.dart';

class SqaDetailView extends StatefulWidget {
  final String eventId;
  const SqaDetailView({super.key, required this.eventId});

  @override
  State<SqaDetailView> createState() => _SqaDetailViewState();
}

class _SqaDetailViewState extends State<SqaDetailView> {
  bool _cantFindEvent = false;

  late SqaEvent? _sqaEvent;
  late Future _loadEventDataFuture;

  @override
  initState() {
    super.initState();
    _loadEventDataFuture = _loadEventData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail View"),
        actions: [
          IconButton(
            onPressed: () {
              List<String> coordinates_string = _sqaEvent!.location.split(",");
              SqaHelper().openMap(double.parse(coordinates_string[0]),
                  double.parse(coordinates_string[1]));
            },
            icon: const Icon(Icons.location_on),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: FutureBuilder(
            future: _loadEventDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  !_cantFindEvent) {
                return _checkVoteIsClosed() && _checkVoteIsClosed()
                    ? ElevatedButton(
                        onPressed: () {},
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style!
                            .copyWith(
                                foregroundColor:
                                    WidgetStatePropertyAll(SqaTheme.fontColor),
                                backgroundColor:
                                    const WidgetStatePropertyAll(Colors.red)),
                        child: const Text("Close Event"),
                      )
                    : ElevatedButton(
                        onPressed: () {},
                        child: const Text("Join Event"),
                      );
              }

              return Container();
            }),
      ),
      body: FutureBuilder(
        future: _loadEventDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (_cantFindEvent) {
              return const Center(
                child: Text("Can not load event. Please try again later"),
              );
            }

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: createEventDetailView(),
                ),
                SliverList.builder(
                  itemBuilder: (context, index) {
                    return _createParticipantListItem(context, index);
                  },
                  itemCount: _sqaEvent!.participants.length,
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: SqaSpacing.largeMargin,
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future _loadEventData() async {
    _cantFindEvent = false;
    _sqaEvent = await EventDao().getEventById(widget.eventId);
    if (_sqaEvent == null) {
      _cantFindEvent = true;
    }
  }

  Widget createEventDetailView() {
    return Container(
      margin: const EdgeInsets.all(SqaSpacing.mediumMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: SqaSpacing.largeMargin,
          ),
          const SizedBox(
            height: SqaSpacing.largeMargin,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Card(
                    child: SizedBox(
                      height: 150,
                      child: QrImageView(data: widget.eventId),
                    ),
                  ),
                  const SizedBox(
                    height: SqaSpacing.largeMargin,
                  ),
                  _checkVoteIsClosed()
                      ? Text(
                          "Start in:",
                          style: Theme.of(context).textTheme.labelMedium,
                        )
                      : Text(
                          "Participation possible until:",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                  EventCountDownWidget(
                    countdown: SqaHelper()
                        .getRemainingTimeToEventStartInSeconds(
                            _checkVoteIsClosed()
                                ? _sqaEvent!.startDate
                                : _sqaEvent!.joinVoteEndDate),
                    onComplete: () {},
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: SqaSpacing.largeMargin,
          ),
          const SizedBox(
            height: SqaSpacing.largeMargin,
          ),
          Text(
            _sqaEvent!.name,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(
            height: SqaSpacing.smallMargin,
          ),
          Text(
            _sqaEvent!.description,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: SqaTheme.subFontColor,
                ),
          ),
          const SizedBox(
            height: SqaSpacing.mediumMargin,
          ),
          Text(
            "Event Type:",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            _sqaEvent!.sportsType,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: SqaTheme.subFontColor,
                ),
          ),
          const SizedBox(
            height: SqaSpacing.mediumMargin,
          ),
          Text(
            "Startdate:",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            _sqaEvent!.startDate,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: SqaTheme.subFontColor,
                ),
          ),
          const SizedBox(
            height: SqaSpacing.mediumMargin,
          ),
          Text(
            "Duration:",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            "${_sqaEvent!.duration} h",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: SqaTheme.subFontColor,
                ),
          ),
          const SizedBox(
            height: SqaSpacing.mediumMargin,
          ),
          Text(
            "Organized by:",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          FutureBuilder(
            future: UsersDao().readUserByUserId(_sqaEvent!.creator),
            builder: (context, snapshot) {
              String creator = _sqaEvent!.creator;

              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                creator = snapshot.data!.username;
              }

              return Text(
                creator,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: SqaTheme.subFontColor,
                    ),
              );
            },
          ),
          const SizedBox(
            height: SqaSpacing.mediumMargin,
          ),
          Text(
            "Already joined (0 / ${_sqaEvent!.maxParticipants}): ",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }

  Widget _createParticipantListItem(BuildContext context, int index) {
    String participant =
        _sqaEvent!.participants[index]; //TODO replace with read username

    return InkWell(
      onTap: () {},
      child: Container(
        margin: SqaSpacing.mediumMarginEdgeInsets,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: SqaSpacing.mediumPaddingEdgeInsets,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: SqaTheme.secondaryColor,
                  ),
                  child: Icon(
                    Icons.person,
                    color: SqaTheme.fontColor,
                  ),
                ),
                const SizedBox(
                  width: SqaSpacing.mediumMargin,
                ),
                Text(
                  participant,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _checkVoteIsClosed() {
    return SqaHelper()
            .getRemainingTimeToEventStartInSeconds(_sqaEvent!.joinVoteEndDate) <
        0;
  }

  bool _checkIsUserEvent() {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (_sqaEvent!.creator == auth.currentUser!.uid) {
      return true;
    }

    return false;
  }
}
