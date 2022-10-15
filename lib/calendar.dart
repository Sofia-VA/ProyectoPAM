// ignore_for_file: prefer_const_constructors

import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/add_to_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _Calendar();
}

class _Calendar extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Calendar"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddToCalendar()));
            },
          )
        ],
      ),
      body: SfCalendar(
        backgroundColor: Colours.ghostWhite,
        dataSource: EventDataSource(events),
        view: CalendarView.month,  
        initialSelectedDate:  DateTime.now(),
        cellBorderColor: Colors.transparent,
        onLongPress: (details){
          final provider = Provider.of<EventProvider>(context, listen: false);
          provider.setDate(details.date!);
          showModalBottomSheet(
            context: context, 
            builder: (context) => TripsCalendar(),
          );
        },
      ),
    );
  }
}
