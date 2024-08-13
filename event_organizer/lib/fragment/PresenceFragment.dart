import 'package:event_organizer/colors/colors.dart';
import 'package:event_organizer/controllers/presenceControllers.dart';
import 'package:event_organizer/view/cardView.dart';
import 'package:event_organizer/view/resultPresenceScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PresenceFragment extends StatefulWidget {
  @override
  _PresenceFragmentState createState() => _PresenceFragmentState();
}

class _PresenceFragmentState extends State<PresenceFragment> {
  final presenceControllers presenceCtrl = Get.put(presenceControllers());

  @override
  void initState() {
    super.initState();
    presenceCtrl.fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.secondColor,
        child: Obx(() {
          final presenceEvents = presenceCtrl.events;
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Presence Event',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ...presenceEvents.map((event) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => resultPresenceScreen(
                              presence: presenceCtrl.presence.value,
                            ),
                          ),
                        );
                      },
                      child: cardView(
                        organizer: event.organizer,
                        imageUrl: event.imageUrl,
                        nameEvent: event.nameEvent,
                        date: event.date,
                        time: event.time,
                        location: event.location,
                        price: event.price,
                        status: event.status,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          );
        }),
      ),
    );
  }
}
