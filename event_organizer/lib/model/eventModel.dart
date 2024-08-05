class Event {
  final int id;
  final String organizer;
  final String imageUrl;
  final String nameEvent;
  final String? description;
  final String date;
  final String time;
  final String location;
  final String? maps;
  final String price;
  final String status;
  final int? invite;

  Event({
    required this.id,
    required this.organizer,
    required this.imageUrl,
    required this.nameEvent,
    this.description,
    required this.date,
    required this.time,
    required this.location,
    this.maps,
    required this.price,
    required this.status,
    this.invite,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organizer': organizer,
      'imageUrl': imageUrl,
      'nameEvent': nameEvent,
      'description': description,
      'date': date,
      'time': time,
      'location': location,
      'maps': maps,
      'price': price,
      'status': status,
      'invite': invite,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      organizer: map['organizer'],
      imageUrl: map['imageUrl'],
      nameEvent: map['nameEvent'],
      description: map['description'],
      date: map['date'],
      time: map['time'],
      location: map['location'],
      maps: map['maps'],
      price: map['price'],
      status: map['status'],
      invite: map['invite'],
    );
  }

  Event copyWith({
    int? id,
    String? organizer,
    String? imageUrl,
    String? nameEvent,
    String? description,
    String? date,
    String? time,
    String? location,
    String? maps,
    String? price,
    String? status,
    int? invite,
  }) {
    return Event(
      id: id ?? this.id,
      organizer: organizer ?? this.organizer,
      imageUrl: imageUrl ?? this.imageUrl,
      nameEvent: nameEvent ?? this.nameEvent,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      location: location ?? this.location,
      maps: maps ?? this.maps,
      price: price ?? this.price,
      status: status ?? this.status,
      invite: invite ?? this.invite,
    );
  }
}
