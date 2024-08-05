import 'package:event_organizer/colors/colors.dart';
import 'package:event_organizer/controllers/orderEventControllers.dart';
import 'package:flutter/material.dart';
import 'package:event_organizer/view/cardView.dart';
import 'package:event_organizer/view/detailEventScreen.dart';
import 'package:get/get.dart';

class OrderedFragment extends StatefulWidget {
  @override
  _OrderedFragmentState createState() => _OrderedFragmentState();
}

class _OrderedFragmentState extends State<OrderedFragment> {
  final orderEventControllers orderEventCtrl = Get.put(orderEventControllers());

  @override
  void initState() {
    super.initState();
    orderEventCtrl.fetchOrderedEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.secondColor,
        child: Obx(() {
          final orderedEvents = orderEventCtrl.orderedEvents;
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Ordered Event',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ...orderedEvents.map((event) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            detailEventScreen(detailEvent: event),
                      ),
                    );
                  },
                  child: cardView(
                    organizer: event.organizer,
                    imageUrl: event.imageUrl,
                    nameEvent: event.nameEvent,
                    date: event.date,
                    time: event.time,
                    location: event.location,
                    price: event.price,
                    status: event.status,
                  ),
                );
              }).toList(),
            ],
          );
        }),
      ),
    );
  }
}
