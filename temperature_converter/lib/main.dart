import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemperatureConverterScreen(),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  @override
  _TemperatureConverterScreenState createState() => _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState extends State<TemperatureConverterScreen> {
  String _selectedConversion = 'FtoC';
  final TextEditingController _controller = TextEditingController();
  String _convertedValue = '';
  List<String> _conversionHistory = [];

  void _convert() {
    final double? inputTemperature = double.tryParse(_controller.text);
    if (inputTemperature == null) return;

    double convertedTemperature;
    String conversionType;
    if (_selectedConversion == 'FtoC') {
      convertedTemperature = (inputTemperature - 32) * 5 / 9;
      conversionType = 'F to C';
    } else {
      convertedTemperature = (inputTemperature * 9 / 5) + 32;
      conversionType = 'C to F';
    }

    setState(() {
      _convertedValue = convertedTemperature.toStringAsFixed(1);
      _conversionHistory.insert(0, '$conversionType: $inputTemperature => $_convertedValue');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.lightBlue[50],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RadioListTile(
                            title: Text('Fahrenheit to Celsius'),
                            value: 'FtoC',
                            groupValue: _selectedConversion,
                            onChanged: (value) {
                              setState(() {
                                _selectedConversion = value as String;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: Text('Celsius to Fahrenheit'),
                            value: 'CtoF',
                            groupValue: _selectedConversion,
                            onChanged: (value) {
                              setState(() {
                                _selectedConversion = value as String;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Enter temperature',
                        labelStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Converted value: $_convertedValue',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _convert,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900],
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 50),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      child: Text('Convert'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: _conversionHistory.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_conversionHistory[index]),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
