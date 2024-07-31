import 'package:get/get.dart';
import 'package:event_organizer/database/databaseBookmark.dart';
import 'package:event_organizer/model/eventModel.dart';

class bookmarkControllers extends GetxController {
  final DatabaseBookmark _databaseBookmark = DatabaseBookmark.instance;

  // Use a set or map to manage bookmarked event IDs
  final RxSet<int> _bookmarkedEventIds = <int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _loadBookmarkedEvents();
  }

  void _loadBookmarkedEvents() async {
    // Load all bookmarked events from database
    final events = await _databaseBookmark.readAllBookmarkedEvents();
    _bookmarkedEventIds.value = events.map((event) => event.id).toSet();
  }

  Future<void> addBookmark(Event event) async {
    await _databaseBookmark.addBookmark(event);
    _bookmarkedEventIds.add(event.id);
  }

  Future<void> removeBookmark(int eventId) async {
    await _databaseBookmark.removeBookmark(eventId);
    _bookmarkedEventIds.remove(eventId);
  }

  Future<bool> isBookmarked(int eventId) async {
    return _bookmarkedEventIds.contains(eventId);
  }
}
