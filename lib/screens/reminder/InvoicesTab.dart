import 'package:flutter/material.dart';

class InvoicesTab extends StatelessWidget {
  const InvoicesTab({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          Text("Inovices Tab!"),
        ],
      ),
    );
  }
}
