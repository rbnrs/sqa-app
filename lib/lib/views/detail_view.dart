import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sqa/entities/sqa_event.dart';
import 'package:sqa/model/event_dao.dart';
import 'package:sqa/model/users_dao.dart';
import 'package:sqa/themes/sqa_spacing.dart';
import 'package:sqa/themes/sqa_theme.dart';
import 'package:sqa/themes/sqa_widget_service.dart';
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
              List<String> coordinatesString = _sqaEvent!.location.split(",");
              SqaHelper().openMap(double.parse(coordinatesString[0]),
                  double.parse(coordinatesString[1]));
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
                FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                String userId = firebaseAuth.currentUser!.uid;
                return _checkVoteIsClosed() && _checkIsUserEvent()
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
                    : !_checkIsUserEvent() &&
                            !_sqaEvent!.participants.contains(userId)
                        ? ElevatedButton(
                            onPressed: () {
                              _joinEvent();
                            },
                            child: const Text("Join Event"),
                          )
                        : !_checkIsUserEvent() &&
                                _sqaEvent!.participants.contains(userId)
                            ? ElevatedButton(
                                style: Theme.of(context)
                                    .elevatedButtonTheme
                                    .style!
                                    .copyWith(
                                        foregroundColor: WidgetStatePropertyAll(
                                            SqaTheme.fontColor),
                                        backgroundColor:
                                            const WidgetStatePropertyAll(
                                                Colors.red)),
                                onPressed: () {
                                  _leaveEvent(userId);
                                },
                                child: const Text("Leave Event"),
                              )
                            : Container();
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
                    color: Colors.white,
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
            "Already joined (${_sqaEvent!.participants.length} / ${_sqaEvent!.maxParticipants}): ",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }

  Widget _createParticipantListItem(BuildContext context, int index) {
    String participant = _sqaEvent!.participants[index];

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    String userId = firebaseAuth.currentUser!.uid;

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
                FutureBuilder(
                  future: UsersDao().readUserByUserId(participant),
                  builder: (context, snapshot) {
                    String userName = participant;
                    if (snapshot.hasData) {
                      userName = snapshot.data!.username;
                    }

                    return Text(
                      userName,
                      style: Theme.of(context).textTheme.titleLarge,
                    );
                  },
                ),
                const Spacer(),
                participant == userId
                    ? Icon(
                        Icons.person,
                        color: SqaTheme.primaryColor,
                      )
                    : Container()
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

  void _joinEvent() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String userId = auth.currentUser!.uid;
    SqaWidgetService().showLoadingDialog(context, "Joining event");
    await EventDao().joinEvent(userId, widget.eventId);
    Navigator.of(context).pop();
    _loadEventDataFuture = _loadEventData();
    setState(() {});
  }

  Future<void> _leaveEvent(String userId) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String userId = auth.currentUser!.uid;
    SqaWidgetService().showLoadingDialog(context, "Joining event");
    await EventDao().removeFromEvent(userId, widget.eventId);
    Navigator.of(context).pop();
    _loadEventDataFuture = _loadEventData();
    setState(() {});
  }
}
