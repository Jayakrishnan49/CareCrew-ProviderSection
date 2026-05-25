import 'package:flutter/material.dart';
import 'package:project_2_provider/model/booking_request_model.dart';
import 'package:project_2_provider/services/schedule_service.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleProvider extends ChangeNotifier {
  final ScheduleService _service = ScheduleService();

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  Stream<List<BookingRequest>>? bookingStream;
  CalendarFormat calendarFormat = CalendarFormat.month; 

  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay = selected;
    focusedDay = focused;
    bookingStream = _service.getBookingsForDay(selected);
    notifyListeners();
  }

  void onFormatChanged(CalendarFormat format) { 
    calendarFormat = format;
    notifyListeners();
  }
}