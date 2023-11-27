import 'package:flutter/material.dart';

class CurrencyCalculator extends StatefulWidget {
  const CurrencyCalculator({Key? key}) : super(key: key);

  @override
  State<CurrencyCalculator> createState() => _CurrencyCalculatorState();
}

class _CurrencyCalculatorState extends State<CurrencyCalculator> {
  double billAmount = 0.0;
  double exchangeRate = 0; // Default exchange rate, you can initialize it with any value
  double equivalentAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Currency Calculator',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Enter Bill Amount (\$)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  billAmount = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Enter Exchange Rate',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  exchangeRate = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculateEquivalentAmount();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black54,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(20.0),
              ),
              child: const Text(
                'Calculate',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            if (billAmount != 0.0)
              Text('Equivalent Amount: ${equivalentAmount.toStringAsFixed(0)}'),
          ],
        ),
      ),
    );
  }

  void calculateEquivalentAmount() {
    setState(() {
      equivalentAmount = billAmount * exchangeRate;
    });
  }
}
