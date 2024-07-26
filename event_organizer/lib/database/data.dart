import 'package:event_organizer/database/databaseHelper.dart';
import 'package:event_organizer/model/eventModel.dart';

Future<void> addInitialEvents() async {
  final dbHelper = DatabaseHelper.instance;

  final event1 = Event(
    organizer: 'Wonderful Indonesia',
    imageUrl:
        'https://imagedelivery.net/17ER9eRTNK7DXk2ppa8ILA/header_dekstop_20240529015430.png/public',
    nameEvent:
        'Minuman Fermentasi Khas Bali yang Bisa Kamu Temui di Ubud Food Festival 2024',
    date: '31 Mei 2024 7.00 PM',
    location: 'Ubud, Bali',
    price: 'Rp. 350.000',
    status: 'Offline',
  );

  final event2 = Event(
    organizer: 'Dinas Pariwisata Nusa Tenggara Barat',
    imageUrl:
        'https://www.indonesia.travel/content/dam/indtravelrevamp/en/events/microsite-event/makna-di-balik-festival-bau-nyale-di-mandalika-lombok/thumbnail.jpg',
    nameEvent: 'Makna di Balik Festival Bau Nyale di Mandalika, Lombok',
    date: '3 Maret 2024 9.00 AM',
    location: 'Mandalika, Lombok',
    price: 'Rp. 200.000',
    status: 'Offline',
  );

  final event3 = Event(
    organizer: 'Wonderful Indonesia',
    imageUrl:
        'https://v1.indonesia.travel/content/dam/indtravelrevamp/id-id/ide-liburan/6-tarian-tradisional-indonesia-yang-indah-penuh-makna-dan-bisa-disaksikan-dari-rumah/header.jpg',
    nameEvent:
        '6 Tarian Tradisional Indonesia yang Indah, Penuh Makna, dan Bisa Disaksikan dari Rumah!',
    date: '21 Oktober 2024 9.00 AM',
    location: 'Summarecon, Jakarta',
    price: 'Rp. 150.000',
    status: 'Offline',
  );

  await dbHelper.create(event1);
  await dbHelper.create(event2);
  await dbHelper.create(event3);
}
