import 'package:flutter/material.dart';
import 'dart:math';

class APYCalculator extends StatefulWidget {
  const APYCalculator({super.key});

  @override
  State<APYCalculator> createState() => _APYCalculatorState();
}

class _APYCalculatorState extends State<APYCalculator> {
  final _principalController = TextEditingController();
  final _interestRateController = TextEditingController();
  final _termController = TextEditingController();

  double _totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _principalController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Principal',
            ),
          ),
          TextField(
            controller: _interestRateController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Annual Interest Rate',
            ),
          ),
          TextField(
            controller: _termController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Term (in years)',
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _calculateTotalAmount,
            child: const Text('Calculate Total Amount'),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Total Amount: \$${_totalAmount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _calculateTotalAmount() {
    double principal = double.tryParse(_principalController.text) ?? 0;
    double interestRate = double.tryParse(_interestRateController.text) ?? 0;
    int term = int.tryParse(_termController.text) ?? 0;

    double apy = pow(1 + interestRate / 1200, 12) - 1;
    double totalAmount = principal * pow(1 + apy, term);

    setState(() {
      _totalAmount = totalAmount;
    });
  }
}
