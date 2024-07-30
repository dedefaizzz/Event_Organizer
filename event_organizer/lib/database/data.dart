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
    description:
        'Ubud Food Festival 2024 kembali hadir pada 31 Mei-2 Juni 2024. Memasuki tahun ke-6, Ubud Food Festival kembali dengan beragam program yang menghadirkan talenta-talenta kuliner baru dan terkemuka dari Indonesia, bersama dengan para chef terbaik Asia dan penerima penghargaan bintang Michelin. Di Food Market Ubud Food Festival tak hanya makanan Indonesia yang akan ada, namun juga hadir minuman fermentasi racikan anak bangsa.',
    date: '31 Mei 2024',
    time: '7.00 PM',
    location: 'Ubud, Bali',
    maps: '-8.506076, 115.260417',
    price: 'Rp. 350.000',
    status: 'Offline',
    invite: 8,
  );

  final event2 = Event(
    organizer: 'Dinas Pariwisata Nusa Tenggara Barat',
    imageUrl:
        'https://www.indonesia.travel/content/dam/indtravelrevamp/en/events/microsite-event/makna-di-balik-festival-bau-nyale-di-mandalika-lombok/thumbnail.jpg',
    nameEvent: 'Makna di Balik Festival Bau Nyale di Mandalika, Lombok',
    description:
        'Festival legendaris di Pulau Lombok yang satu ini merupakan sebuah sejarah yang melekat erat dalam masyarakat Lombok, Nusa Tenggara Barat. Bau Nyale ini merupakan acara tahunan yang selalu disambut meriah oleh warga lokal. Karena antusiasme warga, wisatawan pun semakin penasaran dan berbondong-bondong menyaksikan. Nah, nilai adat dan kepercayaan masyarakat lokal tentang budaya turun temurun seperti ini pastinya wajib dilestarikan dan terus dipertahankan.',
    date: '3 Maret 2024',
    time: '9.00 AM',
    location: 'Mandalika, Lombok',
    maps: '-8.604565, 116.154184',
    price: 'Rp. 200.000',
    status: 'Offline',
    invite: 10,
  );

  final event3 = Event(
    organizer: 'Wonderful Indonesia',
    imageUrl:
        'https://v1.indonesia.travel/content/dam/indtravelrevamp/id-id/ide-liburan/6-tarian-tradisional-indonesia-yang-indah-penuh-makna-dan-bisa-disaksikan-dari-rumah/header.jpg',
    nameEvent:
        '6 Tarian Tradisional Indonesia yang Indah, Penuh Makna, dan Bisa Disaksikan dari Rumah!',
    description:
        'Dari sekian banyak budaya di Indonesia, sekian keunikan yang dimiliki negara kita, beberapa tarian tradisional ini bisa jadi opsi yang menarik. Tentu saja ini bukan berarti tarian yang kami sajikan dalam artikel singkat ini lebih baik dari tarian lain, mengingat semua tarian tradisional memiliki kualitas uniknya masing-masing dan value yang berbeda.',
    date: '21 Oktober 2024',
    time: '9.00 AM',
    location: 'Summarecon, Jakarta',
    maps: '-6.160011, 106.905007',
    price: 'Rp. 150.000',
    status: 'Offline',
    invite: 2,
  );

  await dbHelper.create(event1);
  await dbHelper.create(event2);
  await dbHelper.create(event3);
}
