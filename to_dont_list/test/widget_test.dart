// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:to_dont_list/main.dart';
import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';

void main() {
  test('Item abbreviation should be first letter', () {
    const item = Item(name: "Amazing Spider-Man", hero: "Spider-Man", issueNumber: 129);
    expect(item.abbrev(), "A");
  });

  // Yes, you really need the MaterialApp and Scaffold
  test('Item stores comic correctly', (){
    const item = Item(name: "Amazing Spider-Man", hero: "Spider-Man", issueNumber: 129);
    expect(item.name, "Amazing Spider-Man");
    expect(item.hero, "Spider-Man");
    expect(item.issueNumber, 129);
    }
  );

  testWidgets("Todo list displays comic title", (tester) async{ 
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ToDoListItem(item: const Item(name: "Amazing Spider-Man", hero: "Spider-Man", issueNumber: 129), completed: false, 
        onListChanged: (Item item, bool completed) {}, onDeleteItem: (Item item) {},
      )
      )));
     expect(find.text("Amazing Spider-Man"), findsOneWidget); 
  });
  testWidgets('ToDoListItem displays hero and issue number', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ToDoListItem(item: const Item(name: "Amazing Spider-Man", hero: "Spider-Man", issueNumber: 129), completed: false,
          onListChanged: (Item item, bool completed) {}, onDeleteItem: (Item item) {},
          ),
        ),
      ),
    );
    expect(find.text("Spider-Man - Issue #129"), findsOneWidget);
  });

testWidgets('ToDoListItem has CircleAvatar', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ToDoListItem(item: const Item(name: "Amazing Spider-Man", hero: "Spider-Man", issueNumber: 129), completed: false,
            onListChanged: (Item item, bool completed) {}, onDeleteItem: (Item item) {},
          ),
        ),
      ),
    );

    expect(find.byType(CircleAvatar), findsOneWidget);
  });

testWidgets('Default comic collection starts empty', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ToDoList(),
      ),
    );

    final listItemFinder = find.byType(ToDoListItem);

    expect(listItemFinder, findsNothing);
  });

  testWidgets('Default comic count is zero', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ToDoList(),
      ),
    );

    expect(find.text("Total Comics: 0"), findsOneWidget);
  });

  testWidgets('Add comic dialog contains three text fields', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ToDoList(),
      ),
    );

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    expect(find.byType(TextField), findsNWidgets(3));
  });

  testWidgets('User can add a comic', (tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: ToDoList(),
    ),
  );

  await tester.tap(find.byType(FloatingActionButton));
  await tester.pump();

  final textFields = find.byType(TextField);

  await tester.enterText(textFields.at(0), "Amazing Spider-Man");
  await tester.enterText(textFields.at(1), "Spider-Man");
  await tester.enterText(textFields.at(2), "129");

  await tester.tap(find.byKey(const Key("OKButton")));
  await tester.pump();

  expect(find.text("Amazing Spider-Man"), findsOneWidget);
  expect(find.text("Spider-Man - Issue #129"), findsOneWidget);
});

  testWidgets('Adding comic increases total comic count', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ToDoList(),
      ),
    );

    expect(find.text("Total Comics: 0"), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    final textFields = find.byType(TextField);

    await tester.enterText(textFields.at(0), "Batman");
    await tester.enterText(textFields.at(1), "Batman");
    await tester.enterText(textFields.at(2), "423");

    await tester.tap(find.byKey(const Key("OKButton")));
    await tester.pump();

    expect(find.text("Total Comics: 1"), findsOneWidget);
  });

  testWidgets('Cancel button closes dialog without adding comic',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ToDoList(),
      ),
    );

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    await tester.tap(find.byKey(const Key("CancelButton")));
    await tester.pump();

    expect(find.byType(TextField), findsNothing);
    expect(find.text("Total Comics: 0"), findsOneWidget);
  });
}