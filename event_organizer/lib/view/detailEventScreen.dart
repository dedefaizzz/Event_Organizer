import 'package:event_organizer/colors/colors.dart';
import 'package:event_organizer/model/eventModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class detailEventScreen extends StatefulWidget {
  final Event detailEvent;
  detailEventScreen({required this.detailEvent});

  @override
  _DetailEventScreenState createState() => _DetailEventScreenState();
}

class _DetailEventScreenState extends State<detailEventScreen> {
  bool isExpanded = false;

  void _launchMaps(double latitude, double longitude) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final latLng = widget.detailEvent.maps?.split(',') ?? ['0', '0'];
    final latitude = double.parse(latLng[0]);
    final longitude = double.parse(latLng[1]);

    return Scaffold(
      body: Container(
        color: AppColors.backgroundColor,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.network(widget.detailEvent.imageUrl,
                        fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.asset('assets/wond.jpg',
                              width: 24, height: 24),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '${widget.detailEvent.invite} Friends join event',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      widget.detailEvent.nameEvent,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      widget.detailEvent.description ?? '',
                      maxLines: isExpanded ? null : 4,
                      overflow: isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(isExpanded ? 'See Less' : 'See More'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            icon: Icons.location_on,
                            label: 'Lokasi',
                            value: widget.detailEvent.location,
                          ),
                        ),
                        Expanded(
                          child: _buildInfoCard(
                            icon: Icons.calendar_today_outlined,
                            label: 'Tanggal',
                            value: widget.detailEvent.date,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            icon: Icons.access_time,
                            label: 'Jam',
                            value: widget.detailEvent.time,
                          ),
                        ),
                        Expanded(
                          child: _buildInfoCard(
                            icon: Icons.monetization_on,
                            label: 'HTM',
                            value: widget.detailEvent.price,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: SizedBox(
                        height: 200,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(latitude, longitude),
                            zoom: 17,
                          ),
                          markers: {
                            Marker(
                              markerId: MarkerId('event_location'),
                              position: LatLng(latitude, longitude),
                              infoWindow: InfoWindow(
                                title: widget.detailEvent.nameEvent,
                                snippet: widget.detailEvent.location,
                              ),
                            ),
                          },
                          onTap: (LatLng position) {
                            _launchMaps(latitude, longitude);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 65),
                ],
              ),
            ),
            Positioned(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // bookmark
                    },
                    child: Icon(Icons.bookmark_border),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.secondColor,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // order
                      },
                      child: Text('Order Event'),
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.secondColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      {required IconData icon, required String label, required String value}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 14),
                SizedBox(width: 8),
                Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            SizedBox(height: 8),
            Text(value,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
