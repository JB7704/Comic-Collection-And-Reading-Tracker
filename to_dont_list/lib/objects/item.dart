// Data class to keep the string and have an abbreviation function

class Item {
  const Item({required this.name, required this.hero, required this.issueNumber});

  final String name;
  final String hero;
  final int issueNumber;

  String abbrev() {
    return name.substring(0, 1);
  }
}
