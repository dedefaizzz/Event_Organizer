import 'package:event_organizer/database/databaseOrder.dart';
import 'package:event_organizer/model/eventModel.dart';
import 'package:get/get.dart';

class orderEventControllers extends GetxController {
  var orderedEvents = <Event>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrderedEvents();
  }

  Future<void> fetchOrderedEvents() async {
    final db = DatabaseOrder();
    final events = await db.getOrderedEvents();
    orderedEvents.assignAll(events);
  }

  Future<void> addOrderEvent(Event event) async {
    final db = DatabaseOrder();
    await db.insertEvent(event);
    orderedEvents.add(event);
  }

  Future<bool> isEventOrdered(int eventId) async {
    // final orderedEvents = await DatabaseOrder.instance.readAllEvents();
    return orderedEvents.any((event) => event.id == eventId);
  }
}
