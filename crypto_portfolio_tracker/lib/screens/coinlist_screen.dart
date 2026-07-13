import 'package:flutter/cupertino.dart';

class CoinListsPage extends StatelessWidget {
  const CoinListsPage({super.key, required this.listId});

  final int listId;

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 151, 151, 173),
      child: Center(child: Text('Lists of coins will go here')),
    );
  }
}
