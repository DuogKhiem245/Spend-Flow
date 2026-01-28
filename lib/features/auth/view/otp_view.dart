import 'package:flutter/cupertino.dart';

class OTPPage extends StatefulWidget {
  final String email;
  final String? password;

  const OTPPage({
    super.key,
    required this.email,
    this.password,
  });

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  @override
  Widget build(BuildContext context) {
    throw Container();
  }
}
