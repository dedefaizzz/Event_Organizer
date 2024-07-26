class Event {
  final int? id;
  final String organizer;
  final String imageUrl;
  final String nameEvent;
  final String date;
  final String location;
  final String price;
  final String status;

  Event({
    this.id,
    required this.organizer,
    required this.imageUrl,
    required this.nameEvent,
    required this.date,
    required this.location,
    required this.price,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organizer': organizer,
      'imageUrl': imageUrl,
      'nameEvent': nameEvent,
      'date': date,
      'location': location,
      'price': price,
      'status': status,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      organizer: map['organizer'],
      imageUrl: map['imageUrl'],
      nameEvent: map['nameEvent'],
      date: map['date'],
      location: map['location'],
      price: map['price'],
      status: map['status'],
    );
  }
}
