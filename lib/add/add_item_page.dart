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

  @override
  void initState() {
    super.initState();
    _addItemBloc = AddItemBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new item"),
      ),
      body: BlocProvider<AddItemBloc>(
        builder: (context) => _addItemBloc,
        child: Column(
          children: <Widget>[
            NameInputWidget(),
            _buildQuantityInput(),
            BlocBuilder<AddItemBloc, AddItemState>(builder: (context, state) {
              return _buildDateInput(context, "Adding date", (dateTime) {
                _addItemBloc
                    .add(AddItemAddingDateChangedEvent(dateTime: dateTime));
              }, () => true);
            }),
            BlocBuilder<AddItemBloc, AddItemState>(builder: (context, state) {
              return _buildDateInput(context, "Expiration date", (dateTime) {
                _addItemBloc
                    .add(AddItemExpirationDateChangedEvent(dateTime: dateTime));
              }, () => state.isDateValid);
            }),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              width: double.infinity,
              child: BlocBuilder<AddItemBloc, AddItemState>(
                builder: (context, state) {
                  return RaisedButton(
                    child: Text("Save"),
                    onPressed: state.idFormValid ? () {
                      print("ASdasd");
                    } : null,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDateInput(BuildContext context, String hint,
      Function(DateTime) handler, Function validator) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: DatePicker(
        onDateSelected: handler,
        hint: hint,
        validator: validator,
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
  AddItemBloc addItemBloc;
  final _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    addItemBloc = BlocProvider.of<AddItemBloc>(context);
    _controller.addListener(() {
      addItemBloc.add(AddItemNameEnteredEvent(name: _controller.text));
    });
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<AddItemBloc, AddItemState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
            child: TextFormField(
              maxLines: 1,
              controller: _controller,
              maxLength: 200,
              autovalidate: true,
              validator: (_) {
                return state.isNameValid ? null : "Name invalid";
              },
              decoration: InputDecoration(
                labelText: 'Item name ${state.name}',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            ),
          );
        },
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
