import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sqa/entities/sqa_squad.dart';
import 'package:sqa/model/squad_dao.dart';
import 'package:sqa/themes/sqa_spacing.dart';
import 'package:sqa/themes/sqa_theme.dart';
import 'package:sqa/utils/helper.dart';
import 'package:sqa/widgets/event_count_down_widget.dart';
import 'package:sqa/widgets/squad_member_widget.dart';

class SquadView extends StatefulWidget {
  const SquadView({super.key});

  @override
  State<SquadView> createState() => _SquadViewState();
}

class _SquadViewState extends State<SquadView> {
  List<SqaSquad> _userSquads = [];

  late Future<List<SqaSquad>> _loadSquads;
  SqaSquad? _selectedSquad;

  @override
  initState() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    _loadSquads = SquadDAO().loadSquadsForUser(userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Squad Overview"),
        ),
        body: FutureBuilder(
          future: _loadSquads,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              _userSquads = snapshot.data!;
              if (_userSquads.isNotEmpty) {
                _selectedSquad ??= _userSquads[0];
                return Column(
                  children: [
                    _createSquadSwitchView(),
                    _createSquadOverview(),
                  ],
                );
              }

              return const Center(
                child: Text("No Squads"),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Widget _createSquadSwitchView() {
    return InkWell(
      onTap: () {
        _showSquadSelectionDialog();
      },
      child: Container(
        padding: SqaSpacing.largePaddingEdgeInsets,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _selectedSquad!.squadName,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  _selectedSquad!.squadId,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: SqaTheme.subFontColor,
                      ),
                )
              ],
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_down,
              color: SqaTheme.fontColor,
            )
          ],
        ),
      ),
    );
  }

  Widget _createSquadOverview() {
    return Container(
      margin: SqaSpacing.mediumPaddingEdgeInsets.copyWith(top: 0),
      child: Card(
        child: Container(
          padding: SqaSpacing.mediumPaddingEdgeInsets,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Next Event",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: SqaTheme.subFontColor),
                        ),
                        const SizedBox(
                          height: SqaSpacing.smallMargin,
                        ),
                        Text(
                          "Some EventTitle! THAT IS BIGGER AND BIGGER",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  EventCountDownWidget(
                    lightMode: true,
                    countdown: SqaHelper()
                        .getRemainingTimeToEventStartInSeconds(
                            "01-01-2027 12:00"),
                    onComplete: () {},
                  ),
                ],
              ),
              const SizedBox(
                height: SqaSpacing.largeMargin,
              ),
              TextButton(onPressed: () {}, child: const Text("Go to event"))
            ],
          ),
        ),
      ),
    );
  }

  Widget _createMemberListHeader() {
    return Container(
        margin: SqaSpacing.largeMarginEdgeInsets,
        child: Text(
          "Squad Members",
          style: Theme.of(context).textTheme.titleLarge,
        ));
  }

  void _showSquadSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog.fullscreen(
            child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Select Squad"),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              )
            ],
          ),
          body: ListView.builder(
            itemCount: _userSquads.length,
            itemBuilder: (context, index) {
              SqaSquad sqaSquad = _userSquads[index];
              return InkWell(
                onTap: () {
                  _selectedSquad = sqaSquad;
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: SqaTheme.primaryColor,
                      ),
                    ),
                  ),
                  padding: SqaSpacing.largePaddingEdgeInsets,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            sqaSquad.squadName,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(
                            sqaSquad.squadId,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: SqaTheme.subFontColor,
                                ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: SqaTheme.subFontColor,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
      },
    );
  }
}
