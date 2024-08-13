import 'dart:io';
import 'package:event_organizer/colors/colors.dart';
import 'package:event_organizer/model/presenceModel.dart';
import 'package:flutter/material.dart';

class resultPresenceScreen extends StatefulWidget {
  final Presence presence;

  resultPresenceScreen({required this.presence});

  @override
  _ResultPresenceScreenState createState() => _ResultPresenceScreenState();
}

class _ResultPresenceScreenState extends State<resultPresenceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Presence'),
        backgroundColor: AppColors.secondColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.file(
                File(widget.presence.imagePath),
                height: 400,
                width: 400,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16.0),
              Text('Lokasi', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                  'Latitude: ${widget.presence.latitude}, Longitude: ${widget.presence.longitude}'),
              SizedBox(height: 16.0),
              Text('Waktu', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${widget.presence.timestamp}'),
            ],
          ),
        ),
      ),
    );
  }
}
