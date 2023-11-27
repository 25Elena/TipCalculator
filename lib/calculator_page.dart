import 'package:flutter/material.dart';
import 'split_bill_page.dart';
import 'currency_calculator_page.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  double billAmount = 0.0;
  String selectedCurrency = '\$';
  double tipPercentage = 15;
  double tipAmount = 0.0;
  double totalAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black54,
        centerTitle: true,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Enter Bill Amount',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  billAmount = double.tryParse(value)!;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedCurrency,
              onChanged: (String? value) {
                setState(() {
                  selectedCurrency = value  ?? '\$';
                });
              },
              items: <String>['\$', 'LBP'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Tip Percentage:'),
                DropdownButton<double>(
                  value: tipPercentage,
                  onChanged: (double? value) {
                    setState(() {
                      tipPercentage = value ?? 0.0;
                    });
                  },
                  items: <double>[5, 10, 15, 20, 25, 30].map((double value) {
                    return DropdownMenuItem<double>(
                      value: value,
                      child: Text('$value %'),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tipAmount = (billAmount * tipPercentage) / 100;
                  totalAmount = billAmount + tipAmount;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(20.0),
              ),
              child:const Text('Generate'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SplitBillPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black54,
                foregroundColor: Colors.white,
                padding:const EdgeInsets.all(20.0),
              ),
              child:const Text('Split Bill'),
            ),
            const SizedBox(height: 20),
            if (tipAmount != 0.0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text('Bill Amount: $selectedCurrency ${selectedCurrency == 'LBP'
                      ? billAmount.toStringAsFixed(0)
                      : billAmount.toStringAsFixed(2)}'),
                  Text('Tip Percentage: ${selectedCurrency == 'LBP'
                      ? tipPercentage.toStringAsFixed(0)
                      : tipPercentage.toStringAsFixed(2)}%'),
                  Text('Tip Amount: $selectedCurrency ${selectedCurrency == 'LBP'
                      ? tipAmount.toStringAsFixed(0)
                      : tipAmount.toStringAsFixed(2)}'),
                  const Divider(),
                  Text('Total Amount: $selectedCurrency${selectedCurrency == 'LBP'
                          ? totalAmount.toStringAsFixed(0)
                          : totalAmount.toStringAsFixed(2)}'
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
void navigateToCurrencyCalculator(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const CurrencyCalculator()),
  );
}