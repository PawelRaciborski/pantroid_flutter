import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantroid/add/add_item/add_item_bloc.dart';

import 'date_picker.dart';

class AddItemPage extends StatefulWidget {
  static const route = "/add";

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  AddItemBloc _addItemBloc;
  final _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _addItemBloc = AddItemBloc();
    _controller.addListener(() {
      _addItemBloc.add(AddItemNameEnteredEvent(name: _controller.text));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new item"),
      ),
      body: BlocProvider<AddItemBloc>(
        builder: (context) => _addItemBloc,
        child: BlocListener<AddItemBloc, AddItemState>(
          listener: (context, state) {
            if (state.shouldFinish) {
              Navigator.pop(context);
            }
          },
          child: BlocBuilder<AddItemBloc, AddItemState>(
            builder: (context, state) => Column(
              children: <Widget>[
                _buildNameInput(state),
                _buildQuantityInput(),
                _buildAddingDateInput(context),
                _buildExpirationDateInput(context, state),
                _buildSaveButton(state),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildSaveButton(AddItemState state) => Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: double.infinity,
      child: RaisedButton(
        child: Text("Save"),
        onPressed: state.idFormValid
            ? () {
                _addItemBloc.add(SubmitAddItemFormEvent());
              }
            : null,
      ));

  Container _buildNameInput(AddItemState state) => Container(
        margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
        child: TextFormField(
          maxLines: 1,
          controller: _controller,
          maxLength: 200,
          autovalidate: true,
          validator: (_) => state.isNameValid ? null : "Name invalid",
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

  Widget _buildAddingDateInput(BuildContext context) => Container(
        margin: const EdgeInsets.all(15.0),
        child: DatePicker(
          selectedDate: DateTime.now(),
          onDateSelected: (dateTime) {
            _addItemBloc.add(AddItemAddingDateChangedEvent(dateTime: dateTime));
          },
          hint: "Adding date",
          validator: () => true,
        ),
      );

  Widget _buildExpirationDateInput(BuildContext context, AddItemState state) =>
      Container(
        margin: const EdgeInsets.all(15.0),
        child: DatePicker(
          onDateSelected: (dateTime) {
            _addItemBloc
                .add(AddItemExpirationDateChangedEvent(dateTime: dateTime));
          },
          hint: "Expiration date",
          validator: () => state.isDateValid,
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
