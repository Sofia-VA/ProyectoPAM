// ignore_for_file: prefer_const_constructors, dead_code

import 'package:flutter/material.dart';
import 'package:proyecto/calendar/add_to_calendar.dart';

class EventViewingPage extends StatelessWidget {
  final Event event;

  const EventViewingPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
    leading: CloseButton(),
    ),

    body: ListView(
      padding: EdgeInsets.all(32),
      children: <Widget>[
        
        buildDateTime(event),
        SizedBox(height: 32),
        
        Text(
          event.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Text(
          event.description,
          style: TextStyle(color: Colors.white, fontSize: 18),

        ),

        





      ],
    ),
  );

  Widget buildDateTime(Event event){
    return Column(
      children: [
        buildDate(event.isAllDay ? 'All-day' : 'From', event.from),
        if(!event.isAllDay) buildDate('To', event.to),
      ],
    );
  }

  Widget buildDate(String title, DateTime date){
    return Column();
  }


}