// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<Item> items = [];
  final _itemSet = <Item>{};
  int comicsForHero(String hero) {
    return items.where((item) => item.hero == hero).length;
  }

  void _handleListChanged(Item item, bool completed) {
    setState(() {
      // When a user changes what's in the list, you need
      // to change _itemSet inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      items.remove(item);
      if (!completed) {
        _itemSet.add(item);
        items.add(item);
      } else {
        _itemSet.remove(item);
        items.insert(0, item);
      }
    });
  }

  void _handleDeleteItem(Item item) {
    setState(() {

      items.remove(item);
    });
  }

  void _handleNewItem(String itemText, String hero, int issueNumber, TextEditingController textController) {
    setState(() {
      Item item = Item(name: itemText, hero: hero, issueNumber: issueNumber);
      items.insert(0, item);
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Comic Collection'),
        ),
        body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Total Comics: ${items.length}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: ListView(
              children: items.map((item) {
                return ToDoListItem(
                  item: item,
                  completed: _itemSet.contains(item),
                  onListChanged: _handleListChanged,
                  onDeleteItem: _handleDeleteItem,
                );
              }).toList(),
            ),
          ),
        ],
      ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return ToDoDialog(onListAdded: _handleNewItem);
                  });
            }));
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Comic Collection',
    home: ToDoList(),
  ));
}
