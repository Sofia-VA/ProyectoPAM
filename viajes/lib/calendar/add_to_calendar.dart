// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, empty_constructor_bodies, prefer_const_literals_to_create_immutables, unused_element, unnecessary_string_interpolations, unused_local_variable, override_on_non_overriding_member, use_key_in_widget_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'event_viewing_page.dart';

class Event {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;

  const Event({
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    this.backgroundColor = Colors.lightBlue,
    this.isAllDay = false,
  });
}

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];

  List<Event> get events => _events;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsOfSelectedDate => _events;

  void addEvent(Event event) {
    _events.add(event);

    notifyListeners();
  }

  void editEvent(Event newEvent, Event oldEvent) {
    final index = _events.indexOf(oldEvent);
    _events[index] = newEvent;
    notifyListeners();
  }

  void deleteEvent(Event event) {
    _events.remove(event);
    notifyListeners();
  }
}

class AddToCalendar extends StatefulWidget {
  final Event? event;

  const AddToCalendar({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  _AddToCalendarState createState() => _AddToCalendarState();
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> appointments) {
    this.appointments = appointments;
  }

  Event getEvent(int index) => appointments![index] as Event;

  @override
  DateTime getStartTime(int index) => getEvent(index).from;

  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getTitle(int index) => getEvent(index).title;
}

class TripsCalendar extends StatefulWidget {
  @override
  _TripsCalendarState createState() => _TripsCalendarState();
}

class _TripsCalendarState extends State<TripsCalendar> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;

    if (selectedEvents.isEmpty) {
      return Center(
        child: Text("No events found",
            style: TextStyle(color: Colors.black, fontSize: 20)),
      );
    }

    return SfCalendarTheme(
        data: SfCalendarThemeData(
          timeTextStyle: TextStyle(fontSize: 16, color: Colors.black),
        ),
        child: SfCalendar(
          view: CalendarView.timelineDay,
          dataSource: EventDataSource(provider.events),
          initialDisplayDate: provider.selectedDate,
          appointmentBuilder: appointmentBuilder,
          headerHeight: 0,
          todayHighlightColor: Colors.black,
          selectionDecoration: BoxDecoration(
            color: Colors.transparent,
          ),
          onTap: (details) {
            if (details.appointments == null) return;
            final event = details.appointments!.first;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EventViewingPage(event: event)));
          },
        ));
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    final event = details.appointments.first;
    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        color: event.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _AddToCalendarState extends State<AddToCalendar> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 1));
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add to your Calendar"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.white,
            ),
            onPressed: saveForm,
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                style: TextStyle(fontSize: 24),
                decoration: InputDecoration(
                    border: UnderlineInputBorder(), hintText: 'Add Title'),
                onFieldSubmitted: (_) => saveForm(),
                validator: (title) =>
                    title != null && title.isEmpty ? 'Add a tittle' : null,
                controller: titleController,
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("From",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: buildDropCalendar(
                            text: toDates(fromDate),
                            onClicked: () => pickDate(pickDate: true),
                          )),
                      Expanded(
                          child: buildDropCalendar(
                        text: toTime(fromDate),
                        onClicked: () => pickDate(pickDate: false),
                      ))
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("To",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: buildDropCalendar(
                            text: toDates(toDate),
                            onClicked: () => pickDate(pickDate: true),
                          )),
                      Expanded(
                          child: buildDropCalendar(
                        text: toTime(toDate),
                        onClicked: () => pickDate(pickDate: false),
                      ))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropCalendar({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Future pickDate({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate = DateTime(date.year, date.month, date.day);
    }

    setState(() => fromDate = date);
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime.now(),
          lastDate: DateTime(2025));

      if (date == null) return null;

      final time = Duration(
          hours: initialDate.hour,
          minutes: initialDate.minute,
          seconds: initialDate.second);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);

      final time = Duration(hours: timeOfDay!.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final event = Event(
        title: titleController.text,
        description: "description",
        from: fromDate,
        to: toDate,
        isAllDay: false,
      );

      final provider = Provider.of<EventProvider>(context, listen: false);
      provider.addEvent(event);

      Navigator.of(context).pop();
    }
  }

  static String toDateTime(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);
    final time = DateFormat.Hm().format(dateTime);

    return '$date $time';
  }

  static String toDates(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);

    return '$date';
  }

  static String toTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);

    return '$time';
  }
}
