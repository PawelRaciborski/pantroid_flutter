import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'date_picker.dart';

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
          _buildDateInput(context, "Adding date", (dateTime) {}),
          _buildDateInput(context, "Expiration date", (dateTime) {}),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            width: double.infinity,
            child: RaisedButton(
              child: Text("Save"),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDateInput(
      BuildContext context, String hint, Function(DateTime) handler) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: DatePicker(
        onDateSelected: (dateTime) {
          debugPrint(dateTime.toString());
        },
        hint: hint,
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
}
