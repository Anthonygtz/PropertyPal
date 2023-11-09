import 'package:flutter/material.dart';

class PaymentsTab extends StatelessWidget {
  const PaymentsTab({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          Text("Payment Tab!"),
        ],
      ),
    );
  }
}
