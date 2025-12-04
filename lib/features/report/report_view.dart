import 'package:flutter/cupertino.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Report')),
      child: Center(
        child: Text(
          'Report Page',
          style: CupertinoTheme.of(context).textTheme.textStyle,
        ),
      ),
    );
  }
}
