import 'package:event_organizer/colors/colors.dart';
import 'package:event_organizer/controllers/bookmarkControllers.dart';
import 'package:event_organizer/controllers/orderEventControllers.dart';
import 'package:event_organizer/controllers/presenceControllers.dart';
import 'package:event_organizer/model/eventModel.dart';
import 'package:event_organizer/view/checkinPresenceScreen.dart';
import 'package:event_organizer/view/registerEventScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class detailEventScreen extends StatefulWidget {
  final Event detailEvent;
  detailEventScreen({required this.detailEvent});

  @override
  _DetailEventScreenState createState() => _DetailEventScreenState();
}

class _DetailEventScreenState extends State<detailEventScreen> {
  final bookmarkControllers _bookmarkControllers =
      Get.put(bookmarkControllers());
  final orderEventControllers orderEventCtrl = Get.put(orderEventControllers());
  final presenceControllers presenceCtrl = Get.put(presenceControllers());
  bool isExpanded = false;
  bool _isBookmarked = false;
  bool _isOrdered = false;
  bool _isCheckedIn = false;

  @override
  void initState() {
    super.initState();
    _checkIfBookmarked();
    _checkIfOrdered();
    _checkIfCheckedIn();
  }

  Future<void> _checkIfBookmarked() async {
    bool isBookmarked =
        await _bookmarkControllers.isBookmarked(widget.detailEvent.id);
    setState(() {
      _isBookmarked = isBookmarked;
    });
  }

  void _toggleBookmark() async {
    if (_isBookmarked) {
      _bookmarkControllers.removeBookmark(widget.detailEvent.id);
      Fluttertoast.showToast(msg: 'Event removed from bookmarks');
    } else {
      _bookmarkControllers.addBookmark(widget.detailEvent);
      Fluttertoast.showToast(msg: 'Event added to bookmarks');
    }
    _checkIfBookmarked();
  }

  Future<void> _checkIfOrdered() async {
    bool isOrdered = await orderEventCtrl.isEventOrdered(widget.detailEvent.id);
    setState(() {
      _isOrdered = isOrdered;
    });
  }

  void _orderEvent() {
    Get.to(() => registerEventScreen(event: widget.detailEvent))!.then((value) {
      if (value == true) {
        setState(() {
          _isOrdered = true;
        });
        Fluttertoast.showToast(msg: 'Event ordered successfully');
      }
    });
  }

  Future<void> _checkIfCheckedIn() async {
    bool isCheckedIn = await presenceCtrl.isEventChecked(widget.detailEvent.id);
    setState(() {
      _isCheckedIn = isCheckedIn;
    });
  }

  void _checkIn() {
    Get.to(() => checkinPresenceScreen(event: widget.detailEvent))!
        .then((value) {
      if (value == true) {
        setState(() {
          _isCheckedIn = true;
        });
        Fluttertoast.showToast(msg: 'Checked in successfully');
      }
    });
  }

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
        color: AppColors.secondColor,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(widget.detailEvent.imageUrl,
                          fit: BoxFit.cover),
                    ),
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
                  if (_isOrdered)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: _isCheckedIn ? null : _checkIn,
                        child: Text(_isCheckedIn ? 'Checked In' : 'Check In'),
                        style: ElevatedButton.styleFrom(
                          onPrimary: AppColors.secondColor,
                          minimumSize: Size(double.infinity, 45),
                          onSurface: Colors.green,
                          primary: _isCheckedIn ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  SizedBox(height: 75),
                ],
              ),
            ),
            Positioned(
              top: 32.0,
              left: 6.0,
              child: ElevatedButton(
                child: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.secondColor,
                  onPrimary: AppColors.splashColor,
                  shadowColor: Colors.black.withOpacity(0.5),
                  elevation: 5,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(10),
                ),
              ),
            ),
            Positioned(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
              child: Row(
                children: [
                  ElevatedButton(
                    child: Icon(
                      _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    ),
                    onPressed: _toggleBookmark,
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.secondColor,
                      onPrimary: AppColors.backgroundColor,
                      shadowColor: AppColors.backgroundColor.withOpacity(0.5),
                      elevation: 5,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isOrdered ? null : _orderEvent,
                      child: Text(_isOrdered ? 'Ordered' : 'Order Event'),
                      style: ElevatedButton.styleFrom(
                        primary:
                            _isOrdered ? Colors.grey : AppColors.secondColor,
                        onPrimary: AppColors.splashColor,
                        shadowColor: Colors.black.withOpacity(0.5),
                        elevation: 5,
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
      elevation: 3,
      color: AppColors.secondColor,
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
