import 'package:flutter/material.dart';

class InvestmentsPage extends StatelessWidget {
  const InvestmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Investments')),
      body: Center(child: Text('Investments Page')),
    );
  }
}
