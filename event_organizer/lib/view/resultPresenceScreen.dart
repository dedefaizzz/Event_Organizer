import 'dart:io';
import 'package:event_organizer/model/presenceModel.dart';
import 'package:event_organizer/database/databasePresence.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class resultPresenceScreen extends StatefulWidget {
  final int eventId;

  resultPresenceScreen({required this.eventId});

  @override
  _ResultPresenceScreenState createState() => _ResultPresenceScreenState();
}

class _ResultPresenceScreenState extends State<resultPresenceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check-In Results'),
      ),
      body: FutureBuilder<List<Presence>>(
        future: databasePresence().getPresences(widget.eventId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No check-ins found'));
          } else {
            final presenceList = snapshot.data!;
            return ListView.builder(
              itemCount: presenceList.length,
              itemBuilder: (context, index) {
                final presence = presenceList[index];
                final latitude = presence.latitude;
                final longitude = presence.longitude;

                return Card(
                  margin: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.file(
                          File(presence.imagePath),
                          height: 600,
                          width: 600,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Checked in at: ${presence.timestamp}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Location:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          height: 200,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(latitude, longitude),
                              zoom: 17,
                            ),
                            markers: {
                              Marker(
                                markerId: MarkerId('checkin_location_$index'),
                                position: LatLng(latitude, longitude),
                                infoWindow: InfoWindow(
                                  title: 'Check-In Location',
                                  snippet:
                                      '${presence.latitude}, ${presence.longitude}',
                                ),
                              ),
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
