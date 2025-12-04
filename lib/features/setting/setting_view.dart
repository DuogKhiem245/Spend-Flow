import 'package:flutter/cupertino.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Setting')),
      child: Center(
        child: Text(
          'Setting Page',
          style: CupertinoTheme.of(context).textTheme.textStyle,
        ),
      ),
    );
  }
}
