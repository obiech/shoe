import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_list_pro_project/theme/text_theme.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;

class TableCalenderWidget extends StatefulWidget {
  final Function func;

  const TableCalenderWidget({required this.func});
  @override
  _TableCalenderWidgetState createState() => _TableCalenderWidgetState();
}

class _TableCalenderWidgetState extends State<TableCalenderWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          // markerDecoration: const BoxDecoration(
          //     color: Colors.white, shape: BoxShape.rectangle),
          todayDecoration: const BoxDecoration(
              color: const Color(0xff7D63EB), shape: BoxShape.rectangle),
          selectedDecoration: const BoxDecoration(
              color: const Color(0xff7D63EB), shape: BoxShape.rectangle),
        ),
        // onFormatChanged: (CalendarFormat format) {
        //   _calendarFormat = format;
        // },
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            final text = DateFormat.E().format(day);

            return Center(
              child: Text(
                text.toUpperCase(),
                style: TextStyles.dateStyle,
              ),
            );
          },
        ),
        calendarFormat: _calendarFormat,
        headerVisible: true,
        startingDayOfWeek: StartingDayOfWeek.monday,
        firstDay: DateTime.utc(2020, 10, 16),
        lastDay: DateTime.utc(2100, 3, 14),
        focusedDay: _focusedDay,
        locale: 'ru_RU',
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            if (selectedDay.isAfter(DateTime.now())) {
              _selectedDay = selectedDay;
              widget.func(_selectedDay!.day.toString() +
                  ' ' +
                  _selectedDay!.month.toString() +
                  ', ' +
                  _selectedDay!.year.toString() +
                  '  ' +
                  _selectedDay!.hour.toString() +
                  ':' +
                  _selectedDay!.minute.toString());
              DateTime dateTime = DateTime(
                  _selectedDay!.year, _selectedDay!.month, selectedDay.day,DateTime.now().hour,
                  DateTime.now().minute);
              global.store.set('dateTimeCalender', dateTime);
              _focusedDay = focusedDay;
            } // update `_focusedDay` here as well
          });
        },
        onDayLongPressed: ((selectedDay, focusedDay) {
          setState(() {
            if (selectedDay.isAfter(DateTime.now())) {
              _selectedDay = selectedDay;
              widget.func(_selectedDay!.day.toString() +
                  '-' +
                  _selectedDay!.month.toString() +
                  '-' +
                  _selectedDay!.year.toString() +
                  '  ' +
                  DateTime.now().toLocal().hour.toString() +
                  ':' +
                  DateTime.now().minute.toString());
              DateTime dateTime = DateTime(
                  _selectedDay!.year,
                  _selectedDay!.month,
                  selectedDay.day,
                  DateTime.now().hour,
                  DateTime.now().minute);
              global.store.set('dateTimeCalender', dateTime);

              _focusedDay = focusedDay;
            } // update `_focusedDay` here as well
          });
          Navigator.pop(context);
        }));
  }
}
