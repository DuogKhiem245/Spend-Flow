import 'package:flutter/cupertino.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Budget')),
      child: Center(
        child: Text(
          'Budget Page',
          style: CupertinoTheme.of(context).textTheme.textStyle,
        ),
      ),
    );
  }
}
