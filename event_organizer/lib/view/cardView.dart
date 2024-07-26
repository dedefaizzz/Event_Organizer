import 'package:flutter/material.dart';

class cardView extends StatelessWidget {
  final String organizer;
  final String imageUrl;
  final String nameEvent;
  final String date;
  final String location;
  final String price;
  final String status;

  cardView({
    required this.organizer,
    required this.imageUrl,
    required this.nameEvent,
    required this.date,
    required this.location,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              organizer,
              style: TextStyle(fontSize: 18),
            ),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    nameEvent,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  date,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                ),
                SizedBox(width: 8),
                Text(
                  location,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
                Text(
                  status,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
