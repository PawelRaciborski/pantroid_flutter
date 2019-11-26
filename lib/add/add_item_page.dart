import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantroid/add/add_item/add_item_bloc.dart';

import 'date_picker.dart';

class AddItemPage extends StatelessWidget {
  static const route = "/add";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new item"),
      ),
      body: BlocProvider<AddItemBloc>(
        builder: (context) => AddItemBloc(),
        child: Column(
          children: <Widget>[
            NameInputWidget(),
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

class NameInputWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NameInputWidgetState();
}

class NameInputWidgetState extends State<NameInputWidget> {
  final _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final addItemBloc = BlocProvider.of<AddItemBloc>(context);

    _controller.addListener(() {
      addItemBloc.add(AddItemNameEnteredEvent(name: _controller.text));
    });

    return Container(
      margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
      child: TextFormField(
        maxLines: 1,
        controller: _controller,
        maxLength: 200,
        onEditingComplete: () {},
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


}
