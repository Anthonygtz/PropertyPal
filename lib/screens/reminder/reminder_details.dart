import 'package:flutter/material.dart';
import 'DetailsTab.dart';
import 'BalanceTab.dart';
import 'InvoicesTab.dart';
import 'PaymentsTab.dart';

import '../../widgets/navbar.dart';

class RemindersDetails extends StatelessWidget {
  const RemindersDetails({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("James Richard"),
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.black,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0, color: Colors.black),
              ),
              tabs: [
                Tab(text: 'Details'),
                Tab(text: 'Balance'),
                Tab(text: 'Invoices'),
                Tab(text: 'Payments'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  DetailsTab(),
                  BalanceTab(),
                  InvoicesTab(),
                  PaymentsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(
        selectedIndex: 0,
        onDestinationSelected: (int value) {},
      ),
    );
  }
}
