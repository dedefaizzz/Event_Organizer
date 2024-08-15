import 'dart:io';
import 'package:event_organizer/colors/colors.dart';
import 'package:event_organizer/controllers/presenceControllers.dart';
import 'package:event_organizer/model/eventModel.dart';
import 'package:event_organizer/model/presenceModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class checkinPresenceScreen extends StatefulWidget {
  final Event event;
  checkinPresenceScreen({required this.event});

  @override
  _CheckinPresenceScreenState createState() => _CheckinPresenceScreenState();
}

class _CheckinPresenceScreenState extends State<checkinPresenceScreen> {
  final presenceControllers presenceCtrl = Get.put(presenceControllers());

  @override
  void initState() {
    super.initState();
    presenceCtrl.presence.value = Presence(
      id: 0,
      eventId: widget.event.id,
      imagePath: '',
      latitude: 0.0,
      longitude: 0.0,
      timestamp: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validate Presence'),
        backgroundColor: AppColors.secondColor,
      ),
      body: Obx(() {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: AppColors.secondColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: presenceCtrl.presence.value.imagePath.isEmpty
                    ? Icon(Icons.image, size: 200)
                    : Image.file(File(presenceCtrl.presence.value.imagePath)),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await presenceCtrl.takePicture(widget.event.id);
                },
                child: Text('Ambil Gambar'),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.secondColor,
                  onPrimary: AppColors.splashColor,
                  minimumSize: Size(150, 50),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (presenceCtrl.presence.value.imagePath.isNotEmpty) {
                    try {
                      await presenceCtrl
                          .savePresence(presenceCtrl.presence.value);
                      final preEvent = widget.event.copyWith();
                      presenceCtrl.addEvent(preEvent);
                      Get.back(result: true);
                    } catch (e) {
                      Get.snackbar('Error', 'Gagal menyimpan presence',
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  } else {
                    Get.snackbar('Error', 'Ambil gambar terlebih dahulu',
                        snackPosition: SnackPosition.BOTTOM);
                  }
                },
                child: Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.secondColor,
                  onPrimary: AppColors.splashColor,
                  minimumSize: Size(150, 50),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
