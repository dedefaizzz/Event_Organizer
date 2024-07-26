import 'package:event_organizer/colors/colors.dart';
import 'package:event_organizer/view/cardView.dart';
import 'package:flutter/material.dart';

class HomeFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'New Event',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          cardView(
            organizer: 'Wonderful Indonesia',
            imageUrl:
                'https://imagedelivery.net/17ER9eRTNK7DXk2ppa8ILA/header_dekstop_20240529015430.png/public',
            nameEvent:
                'Minuman Fermentasi Khas Bali yang Bisa Kamu Temui di Ubud Food Festival 2024',
            date: '31 Mei 2024 7.00 PM',
            location: 'Ubud, Bali',
            price: 'Rp. 350.000',
            status: 'Offline',
          ),
          cardView(
            organizer: 'Dinas Pariwisata Nusa Tenggara Barat',
            imageUrl:
                'https://www.indonesia.travel/content/dam/indtravelrevamp/en/events/microsite-event/makna-di-balik-festival-bau-nyale-di-mandalika-lombok/thumbnail.jpg',
            nameEvent: 'Makna di Balik Festival Bau Nyale di Mandalika, Lombok',
            date: '3 Maret 2024 9.00 AM',
            location: 'Mandalika, Lombok',
            price: 'Rp. 200.000',
            status: 'Offline',
          ),
        ],
      ),
    );
  }
}
