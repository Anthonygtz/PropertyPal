import 'package:flutter/material.dart';

class BalanceTab extends StatelessWidget {
  const BalanceTab({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          Text("Balance Tab!"),
        ],
      ),
    );
  }
}
