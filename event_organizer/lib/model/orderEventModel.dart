class orderEventModel {
  final String id;
  final String organizer;
  final String imageUrl;
  final String nameEvent;
  final String date;
  final String time;
  final String location;
  final String price;
  final String status;

  orderEventModel({
    required this.id,
    required this.organizer,
    required this.imageUrl,
    required this.nameEvent,
    required this.date,
    required this.time,
    required this.location,
    required this.price,
    required this.status,
  });
}
