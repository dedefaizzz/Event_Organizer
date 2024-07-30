import 'package:event_organizer/colors/colors.dart';
import 'package:event_organizer/view/cardView.dart';
import 'package:event_organizer/view/detailEventScreen.dart';
import 'package:flutter/material.dart';
import 'package:event_organizer/database/databaseHelper.dart';
import 'package:event_organizer/model/eventModel.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  final dbHelper = DatabaseHelper.instance;
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  void fetchEvents() async {
    final data = await dbHelper.readAllEvents();
    setState(() {
      events = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'New Event',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ...events
              .map(
                (event) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            detailEventScreen(detailEvent: event),
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
              )
              .toList(),
        ],
      ),
    );
  }
}
