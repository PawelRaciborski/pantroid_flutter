import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final Function validator;
  final String hint;

  DatePicker(
      {this.selectedDate, @required this.onDateSelected, @required this.hint, this.validator});

  @override
  State<StatefulWidget> createState() =>
      DatePickerState(selectedDate: selectedDate);
}

class DatePickerState extends State<DatePicker> {
  final _dateTimeFormatter = DateFormat("yyyy-MM-dd");

  DateTime selectedDate;

  DatePickerState({this.selectedDate});

  String get _displayText {
    if (selectedDate != null) {
      return "${widget.hint}: ${_dateTimeFormatter.format(selectedDate)}";
    } else {
      return "${widget.hint}: -";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              _displayText,
              style: TextStyle(color: widget.validator() ?? true ? Colors.black: Colors.red,),
            ),
          ),
          Icon(Icons.calendar_today),
        ],
      ),
      onTap: () =>
          _showDatePicker(context, selectedDate, (dateTime) {
            setState(() {
              selectedDate = dateTime;
            });
            widget.onDateSelected(dateTime);
          }),
    );
  }

  Future<void> _showDatePicker(BuildContext context,
      DateTime initialDate,
      Function(DateTime) onDateSelected,) async {
    final DateTime picked = await showDatePicker(
      context: context,
      firstDate: DateTime.fromMillisecondsSinceEpoch(0),
      lastDate: DateTime.now().add(Duration(days: 1000)),
      initialDate: initialDate ?? DateTime.now(),
    );
    onDateSelected(picked);
  }
}
