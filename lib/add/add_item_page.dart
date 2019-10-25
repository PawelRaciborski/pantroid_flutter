import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddItemPage extends StatelessWidget {
  static const route = "/add";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new item"),
      ),
      body: Column(
        children: <Widget>[
          _buildNameInput(),
          _buildQuantityInput(),
          _buildDateInput(context)
        ],
      ),
    );
  }

  Widget _buildDateInput(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: _DatePicker(onDateSelected: (dateTime) {
                debugPrint(dateTime.toString());
              })),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              _showDatePicker(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNameInput() => Container(
        margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
        child: TextFormField(
          maxLines: 1,
          maxLength: 200,
          decoration: InputDecoration(
            labelText: 'Item name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        ),
      );

  Widget _buildQuantityInput() => Container(
        margin: const EdgeInsets.all(5.0),
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: 'Quantity',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        ),
      );

  Future<void> _showDatePicker(BuildContext context) async {}
}

class _DatePicker extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  _DatePicker({this.selectedDate, @required this.onDateSelected});

  @override
  State<StatefulWidget> createState() => _DatePickerState(
      selectedDate: selectedDate);
}

class _DatePickerState extends State<_DatePicker> {
  DateTime selectedDate;

  _DatePickerState({this.selectedDate});

  String get _displayText {
    if (selectedDate != null) {
      return selectedDate.toString();
    } else {
      return "Adding date";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        _displayText,
      ),
      onTap: () => _showDatePicker(context, selectedDate, (dateTime) {
        setState(() {
          selectedDate = dateTime;
        });
        widget.onDateSelected(dateTime);
      }),
    );
  }

  Future<void> _showDatePicker(
    BuildContext context,
    DateTime initialDate,
    Function(DateTime) onDateSelected,
  ) async {
    final DateTime picked = await showDatePicker(
      context: context,
      firstDate: DateTime.fromMillisecondsSinceEpoch(0),
      lastDate: DateTime.now().add(Duration(days: 1000)),
      initialDate: initialDate ?? DateTime.now(),
    );
    onDateSelected(picked);
  }
}
