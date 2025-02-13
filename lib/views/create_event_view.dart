// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqa/entities/sport_type.dart';
import 'package:sqa/entities/sqa_event.dart';
import 'package:sqa/model/event_dao.dart';
import 'package:sqa/model/sports_dao.dart';
import 'package:sqa/themes/sqa_spacing.dart';
import 'package:sqa/themes/sqa_theme.dart';
import 'package:sqa/themes/sqa_widget_service.dart';
import 'package:sqa/utils/helper.dart';
import 'package:sqa/views/location_picker_view.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key});

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  final _startDatePlaceholder = "Pick a start date";
  final _joinVoteEndDatePlaceholder = "Pick a date for vote end";
  final _durationPlaceholder = "Pick a duration";
  final _locationPlaceholder = "Pick a location";

  String? _eventName;
  String? _eventDescription;
  String? _selectedSportsType;
  String? _startDate;
  String? _joinVoteEndDate;
  String? _duration;
  String? _location;
  double _numberOfPatients = 2;
  double _minParticipants = 2;

  final _formKey = GlobalKey<FormState>();

  DateTime? _startDateEvent;
  DateTime? _joinVoteEndDateEvent;

  @override
  initState() {
    super.initState();
    _startDate = _startDatePlaceholder;
    _duration = _durationPlaceholder;
    _location = _locationPlaceholder;
    _joinVoteEndDate = _joinVoteEndDatePlaceholder;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Event"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: createEventForm(),
          )
        ],
      ),
    );
  }

  Widget createEventForm() {
    return Container(
        padding: SqaSpacing.mediumPaddingEdgeInsets,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: SqaTheme.fontColor),
              ),
              const SizedBox(
                height: SqaSpacing.smallMargin,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please add a event name";
                  }
                  return null;
                },
                onChanged: (value) {
                  _eventName = value;
                },
                cursorColor: SqaTheme.secondaryColor,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: SqaTheme.fontColor),
              ),
              const SizedBox(
                height: SqaSpacing.largeMargin,
              ),
              Text(
                "Event Type",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: SqaTheme.fontColor),
              ),
              const SizedBox(
                height: SqaSpacing.smallMargin,
              ),
              createEventTypePicker(),
              const SizedBox(
                height: SqaSpacing.largeMargin,
              ),
              Text(
                "Startdate",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: SqaTheme.fontColor),
              ),
              const SizedBox(
                height: SqaSpacing.smallMargin,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: OutlinedButton(
                  onPressed: () async {
                    DateTime? dateTime = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(
                          DateTime.now().year + 1,
                          DateTime.now().month,
                          DateTime.now().day,
                        ));

                    if (dateTime == null) return;

                    TimeOfDay? timeOfDay = await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 0, minute: 0),
                    );

                    if (timeOfDay == null) return;

                    _startDateEvent = dateTime;
                    _startDateEvent = _startDateEvent!.copyWith(
                        hour: timeOfDay.hour, minute: timeOfDay.minute);

                    DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm");
                    _startDate = dateFormat.format(_startDateEvent!);

                    setState(() {});
                  },
                  child: Text(_startDate!),
                ),
              ),
              const SizedBox(
                height: SqaSpacing.largeMargin,
              ),
              Text(
                "Duration",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: SqaTheme.fontColor),
              ),
              const SizedBox(
                height: SqaSpacing.smallMargin,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: OutlinedButton(
                  onPressed: () async {
                    TimeOfDay? timeOfDay = await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 0, minute: 0),
                    );

                    if (timeOfDay == null) return;

                    String duration = timeOfDay.format(context);
                    _duration = duration;
                    setState(() {});
                  },
                  child: Text(_duration!),
                ),
              ),
              const SizedBox(
                height: SqaSpacing.smallPadding,
              ),
              _duration != _durationPlaceholder &&
                      _startDate != _startDatePlaceholder
                  ? Text(
                      "Endtime for Event: ${SqaHelper().getEndtimeForEvent(_startDate, _duration)}")
                  : Container(),
              const SizedBox(
                height: SqaSpacing.largeMargin,
              ),
              Text(
                "Number of participants ${_minParticipants.toInt()} (max. ${_numberOfPatients.toInt()})",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: SqaTheme.fontColor),
              ),
              const SizedBox(
                height: SqaSpacing.smallMargin,
              ),
              RangeSlider(
                //TODO customize from backend
                values: RangeValues(_minParticipants, _numberOfPatients),
                max: 30,
                divisions: 30,
                min: 2,
                onChanged: (val) {
                  setState(() {
                    _numberOfPatients = val.end;
                    _minParticipants = val.start;
                  });
                },
              ),
              const SizedBox(
                height: SqaSpacing.largeMargin,
              ),
              Text(
                "Location",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: SqaTheme.fontColor),
              ),
              const SizedBox(
                height: SqaSpacing.smallMargin,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (_) => const LocationPickerView()))
                        .then((location) {
                      dynamic latitude = location['latitude'];
                      dynamic longitude = location['longitude'];

                      _location = "$latitude, $longitude";

                      setState(() {});
                    });
                  },
                  child: Text(_location!),
                ),
              ),
              const SizedBox(
                height: SqaSpacing.largeMargin,
              ),
              Text(
                "Join Enddate",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: SqaTheme.fontColor),
              ),
              Text(
                "*decide until when people may participate in the event",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: SqaTheme.subFontColor),
              ),
              const SizedBox(
                height: SqaSpacing.smallMargin,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: OutlinedButton(
                  onPressed: () async {
                    DateTime? dateTime = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(
                          DateTime.now().year + 1,
                          DateTime.now().month,
                          DateTime.now().day,
                        ));

                    if (dateTime == null) return;

                    TimeOfDay? timeOfDay = await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 0, minute: 0),
                    );

                    if (timeOfDay == null) return;

                    _joinVoteEndDateEvent = dateTime;
                    _joinVoteEndDateEvent = _startDateEvent!.copyWith(
                        hour: timeOfDay.hour, minute: timeOfDay.minute);

                    DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm");
                    _joinVoteEndDate =
                        dateFormat.format(_joinVoteEndDateEvent!);

                    setState(() {});
                  },
                  child: Text(_joinVoteEndDate!),
                ),
              ),
              const SizedBox(
                height: SqaSpacing.largeMargin,
              ),
              Text(
                "Description",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: SqaTheme.fontColor),
              ),
              const SizedBox(
                height: SqaSpacing.smallMargin,
              ),
              TextFormField(
                cursorColor: SqaTheme.secondaryColor,
                maxLines: 6,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please add a event description";
                  }
                  return null;
                },
                onChanged: (value) {
                  _eventDescription = value;
                },
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: SqaTheme.fontColor),
              ),
              const SizedBox(
                height: SqaSpacing.largeMargin,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _createSqaEvent();
                  },
                  child: const Text("Create Event"),
                ),
              )
            ],
          ),
        ));
  }

  Widget createEventTypePicker() {
    List<DropdownMenuItem> eventTypeButtons = [];

    for (SportType sportType in SportsDao().getSportsTypes()) {
      eventTypeButtons.add(DropdownMenuItem(
        value: sportType.name,
        child: Row(
          children: [
            Icon(
              sportType.icon,
              color: SqaTheme.fontColor,
            ),
            const SizedBox(
              width: SqaSpacing.mediumMargin,
            ),
            Text(
              sportType.name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: SqaTheme.fontColor),
            ),
          ],
        ),
      ));
    }
    return DropdownButtonFormField(
      onChanged: (val) {
        _selectedSportsType = val;
      },
      validator: (value) {
        if (value == null) {
          return "Please select a event type";
        }

        return null;
      },
      borderRadius: BorderRadius.circular(5),
      dropdownColor: SqaTheme.backgroundColor,
      items: eventTypeButtons,
    );
  }

  Future<void> _createSqaEvent() async {
    String? uuid = FirebaseAuth.instance.currentUser?.uid;

    if (uuid == null) {
      SqaWidgetService().showErrorSnackbar(
          context, "Something went wrong. Please try again later..");
      return;
    }

    SqaWidgetService().showLoadingDialog(context, "Create Sqa Event...");

    if (!_formKey.currentState!.validate()) {
      SqaWidgetService()
          .showErrorSnackbar(context, "Please check input fields!");
      Navigator.of(context).pop();
      return;
    }

    if (_startDate == _startDatePlaceholder) {
      SqaWidgetService()
          .showErrorSnackbar(context, "Please select a event date!");
      Navigator.of(context).pop();
      return;
    }

    if (_joinVoteEndDate == _joinVoteEndDatePlaceholder) {
      SqaWidgetService().showErrorSnackbar(
          context, "Please select a end date for joining the event!");
      Navigator.of(context).pop();
      return;
    }

    if (_location == _locationPlaceholder) {
      SqaWidgetService()
          .showErrorSnackbar(context, "Please select a event location!");
      Navigator.of(context).pop();
      return;
    }

    if (_duration == _durationPlaceholder) {
      SqaWidgetService()
          .showErrorSnackbar(context, "Please select a event duration!");
      Navigator.of(context).pop();
      return;
    }

    if (_startDateEvent!.millisecondsSinceEpoch <
        _joinVoteEndDateEvent!.millisecondsSinceEpoch) {
      SqaWidgetService().showErrorSnackbar(
          context, "Vote enddate can not be in the future of the event!");
      Navigator.of(context).pop();
      return;
    }

    if (_minParticipants > _numberOfPatients) {
      SqaWidgetService().showErrorSnackbar(context,
          "Min. Participants can not be greater than max. Participants!");
      Navigator.of(context).pop();
      return;
    }

    SqaEvent sqaEvent = SqaEvent(
      id: "",
      name: _eventName!,
      sportsType: _selectedSportsType!,
      creator: uuid,
      startDate: _startDate!,
      joinVoteEndDate: _joinVoteEndDate!,
      location: _location!,
      description: _eventDescription!,
      minParticipants: _numberOfPatients.toInt(),
      maxParticipants: _numberOfPatients.toInt(),
      duration: _duration!,
      participants: [],
    );

    String eventId = await EventDao().createSqaEvent(sqaEvent);

    String routeName = Uri(
      path: '/detail',
      queryParameters: {
        'eventId': eventId,
      },
    ).toString();

    SqaWidgetService().showSnackbar(context, "Successful");
    Navigator.of(context)
        .pushNamedAndRemoveUntil(routeName, ModalRoute.withName('/home'));
  }
}
