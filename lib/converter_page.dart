import 'package:flutter/material.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  final TextEditingController _celsiusController = TextEditingController();
  final TextEditingController _fahrenheitController = TextEditingController();

  double _celsius = 0;
  double _fahrenheit = 0;

  void _convertCelsiusToFahrenheit() {
    setState(() {
      _celsius = double.parse(_celsiusController.text);
      _fahrenheit = (_celsius * 9 / 5) + 32;
      _fahrenheitController.text = _fahrenheit.toStringAsFixed(2);
    });
  }

  void _clearValues() {
    setState(() {
      _celsiusController.text = "";
      _fahrenheitController.text = "";
      _celsius = 0;
      _fahrenheit = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: _celsiusController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Celsius',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _fahrenheitController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Fahrenheit',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _convertCelsiusToFahrenheit,
                child: const Text('Convert'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _clearValues,
                child: const Text('Clear'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
