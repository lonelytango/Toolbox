import 'package:flutter/material.dart';
import 'dart:math';

class AmortizationPage extends StatefulWidget {
  const AmortizationPage({super.key});

  @override
  State<AmortizationPage> createState() => _AmortizationPageState();
}

class _AmortizationPageState extends State<AmortizationPage> {
  final _formKey = GlobalKey<FormState>();
  final _loanAmountController = TextEditingController();
  final _interestRateController = TextEditingController();
  final _termYearsController = TextEditingController();
  final _termMonthsController = TextEditingController();

  double _monthlyPayment = 0;
  List<Map<String, dynamic>> _schedule = [];

  void _calculateAmortizationSchedule() {
    setState(() {
      double loanAmount = double.parse(_loanAmountController.text);
      double interestRate = double.parse(_interestRateController.text);
      int termYears = int.parse(_termYearsController.text);
      int termMonths = int.parse(_termMonthsController.text);
      int numPayments = termYears * 12 + termMonths;
      double monthlyRate = interestRate / 1200;
      _monthlyPayment =
          (loanAmount * monthlyRate) / (1 - pow(1 + monthlyRate, -numPayments));
      double balance = loanAmount;
      for (int i = 1; i <= numPayments; i++) {
        double interest = balance * monthlyRate;
        double principal = _monthlyPayment - interest;
        balance -= principal;
        _schedule.add({
          'month': i,
          'payment': _monthlyPayment,
          'interest': interest,
          'principal': principal,
          'balance': balance,
        });
      }
    });
  }

  void _clearValues() {
    setState(() {
      _loanAmountController.text = "";
      _interestRateController.text = "";
      _termYearsController.text = "";
      _termMonthsController.text = "";
      _monthlyPayment = 0;
      _schedule = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _loanAmountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Loan Amount',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a loan amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _interestRateController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Interest Rate',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an interest rate';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _termYearsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Term (years)',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a term in years';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _termMonthsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Term (months)',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a term in months';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  child: const Text('Calculate'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _calculateAmortizationSchedule();
                    }
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  child: const Text('Clear'),
                  onPressed: () {
                    _clearValues();
                  },
                ),
                const SizedBox(height: 16),
                if (_monthlyPayment > 0)
                  Text(
                    'Monthly Payment: \$${_monthlyPayment.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20),
                  ),
                const SizedBox(height: 16),
                if (_schedule.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: _schedule.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Month ${_schedule[index]['month']}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Payment: \$${_schedule[index]['payment'].toStringAsFixed(2)}'),
                              Text(
                                  'Interest: \$${_schedule[index]['interest'].toStringAsFixed(2)}'),
                              Text(
                                  'Principal: \$${_schedule[index]['principal'].toStringAsFixed(2)}'),
                              Text(
                                  'Balance: \$${_schedule[index]['balance'].toStringAsFixed(2)}'),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ]),
        ));
  }
}
