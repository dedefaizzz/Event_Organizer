import 'package:event_organizer/colors/colors.dart';
import 'package:event_organizer/database/databaseBookmark.dart';
import 'package:event_organizer/model/eventModel.dart';
import 'package:event_organizer/view/cardView.dart';
import 'package:event_organizer/view/detailEventScreen.dart';
import 'package:flutter/material.dart';

class BookmarkFragment extends StatefulWidget {
  @override
  _BookmarkFragmentState createState() => _BookmarkFragmentState();
}

class _BookmarkFragmentState extends State<BookmarkFragment> {
  final dbHelper = DatabaseBookmark.instance;
  List<Event> bookmarkedEvents = [];

  @override
  void initState() {
    super.initState();
    fetchBookmarkedEvents();
  }

  void fetchBookmarkedEvents() async {
    final data = await dbHelper.readAllBookmarkedEvents();
    setState(() {
      bookmarkedEvents = data;
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
                'Bookmark Event',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ...bookmarkedEvents
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
