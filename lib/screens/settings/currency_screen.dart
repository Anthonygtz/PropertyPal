import 'package:flutter/material.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({Key? key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  String selectedCurrency = '';

  void selectCurrency(String currency) {
    setState(() {
      selectedCurrency = currency;
    });
  }

  Widget buildCurrencyButton(String currency, String label) {
    Color color = selectedCurrency == currency ? Colors.black : Colors.blue;

    return InkWell(
      onTap: () {
        selectCurrency(currency);
      },
      child: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildCurrencyButton('CAD', 'CAD'),
            SizedBox(height: 20),
            buildCurrencyButton('USD', 'USD'),
            SizedBox(height: 20),
            buildCurrencyButton('MEX', 'MEX'),
            SizedBox(height: 20),
            Text(
              'Selected currency: $selectedCurrency',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
