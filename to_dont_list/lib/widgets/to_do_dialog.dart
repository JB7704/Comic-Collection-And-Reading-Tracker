import 'package:flutter/material.dart';

typedef ToDoListAddedCallback = Function(
    String name, String hero, int issueNumber, TextEditingController textController);
  

class ToDoDialog extends StatefulWidget {
  const ToDoDialog({
    super.key,
    required this.onListAdded,
  });

  final ToDoListAddedCallback onListAdded;

  @override
  State<ToDoDialog> createState() => _ToDoDialogState();
}

class _ToDoDialogState extends State<ToDoDialog> {
  // Dialog with text from https://www.appsdeveloperblog.com/alert-dialog-with-a-text-field-in-flutter/
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _heroController = TextEditingController();
  final TextEditingController _issueNumber = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  String valueText = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Item To Add'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [ 
          TextField(
            controller: _inputController,
            decoration: const InputDecoration(
              hintText: "Comic Title"

            ),
          ),
          TextField(
            controller: _heroController,
            decoration: const InputDecoration(
              hintText: "Hero Name"
            ),
          ),
          TextField(
            controller: _issueNumber,
            decoration: const InputDecoration(
              hintText: "Issue Number"
            ),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          key: const Key("OKButton"),
          style: yesStyle,
          child: const Text('OK'),
          onPressed: () {
            widget.onListAdded(_inputController.text, _heroController.text, int.parse(_issueNumber.text), _inputController,);
            Navigator.pop(context);
          },
        ),

        // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
        ElevatedButton(
          key: const Key("CancelButton"),
          style: noStyle,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
          ),
      ],
    );
    
  }
}
