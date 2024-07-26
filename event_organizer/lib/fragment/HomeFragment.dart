import 'package:event_organizer/colors/colors.dart';
import 'package:event_organizer/view/cardView.dart';
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
    return InkWell(
      onTap: () {
        // navigate to detail event
      },
      child: Container(
        color: AppColors.backgroundColor,
        child: ListView.builder(
          itemCount: events.length + 1, // Incremented to account for the header
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'New Event',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            } else {
              final event = events[index - 1]; // Adjust index for events
              return cardView(
                organizer: event.organizer,
                imageUrl: event.imageUrl,
                nameEvent: event.nameEvent,
                date: event.date,
                location: event.location,
                price: event.price,
                status: event.status,
              );
            }
          },
        ),
      ),
    );
  }
}
