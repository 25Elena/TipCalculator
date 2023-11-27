import 'package:flutter/material.dart';
import 'currency_calculator_page.dart';

class SplitBillPage extends StatefulWidget {
  const SplitBillPage({Key? key}) : super(key: key);

  @override
  State<SplitBillPage> createState() => _SplitBillPageState();
}

class _SplitBillPageState extends State<SplitBillPage> {
  int numberOfPeople = 1;
  double splitAmount = 0.0;
  String totalAmount = '';
  String selectedCurrency = '\$';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Split Bill',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black54,
        actions: [
          IconButton(
            icon: const Icon(Icons.attach_money),
            color:  Colors.white,
            onPressed: () {
              navigateToCurrencyCalculator(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() {
                  totalAmount = value;
                });
              },
               decoration: const InputDecoration(
                labelText: 'Enter Total Amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  numberOfPeople = int.tryParse(value) ?? 1;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Enter Number of People',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedCurrency = '\$';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedCurrency == '\$'
                        ? Colors.indigo
                        : Colors.black54,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(20.0),
                  ),
                  child: const Text('\$'),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedCurrency = 'LBP';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedCurrency == 'LBP'
                        ? Colors.indigo
                        : Colors.black54,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(20.0),
                  ),
                  child: const Text('LBP'),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _calculateSplitAmount();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black54,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(20.0),
              ),
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Split Amount: $selectedCurrency ${selectedCurrency == 'LBP'
                  ? splitAmount.toStringAsFixed(0)
                  : splitAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  void _calculateSplitAmount() {
    double total = double.tryParse(totalAmount) ?? 0.0;
    setState(() {
      splitAmount = total / numberOfPeople;
    });
  }
}

void navigateToCurrencyCalculator(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const CurrencyCalculator()),
  );
}
