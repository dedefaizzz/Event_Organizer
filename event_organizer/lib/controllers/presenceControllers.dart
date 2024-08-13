import 'package:event_organizer/database/databaseEvent.dart';
import 'package:event_organizer/database/databasePresence.dart';
import 'package:event_organizer/model/eventModel.dart';
import 'package:event_organizer/model/presenceModel.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class presenceControllers extends GetxController {
  var isLoading = false.obs;
  var events = <Event>[].obs;
  var presence = Presence(
    id: 0,
    imagePath: '',
    latitude: 0.0,
    longitude: 0.0,
    timestamp: DateTime.now(),
  ).obs;

  final ImagePicker _imagePicker = ImagePicker();
  final Location _location = Location();

  @override
  void onInit() {
    fetchEvents();
    super.onInit();
  }

  Future<void> takePicture() async {
    try {
      final pickedFile =
          await _imagePicker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        final locationData = await _location.getLocation();
        presence.update((val) {
          val!.imagePath = pickedFile.path;
          val.latitude = locationData.latitude!;
          val.longitude = locationData.longitude!;
          val.timestamp = DateTime.now();
        });
        await savePresence(presence.value);
      }
    } finally {
      isLoading(false);
    }
  }

  void resetPresence() {
    presence.value.imagePath = '';
  }

  Future<void> savePresence(Presence presenceData) async {
    final db = databasePresence();
    return await db.insertPresence(presenceData);
  }

  Future<void> fetchEvents() async {
    try {
      isLoading(true);
      var events = await databaseEvent().getEvents();
      events.assignAll(events);
    } finally {
      isLoading(false);
    }
  }

  Future<void> addEvent(Event event) async {
    final db = databaseEvent();
    await db.insertEvent(event);
    events.add(event);
  }

  Future<bool> isEventChecked(int eventId) async {
    return events.any((event) => event.id == eventId);
  }
}
