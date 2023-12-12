import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';

class StreetSelectionScreen extends StatefulWidget {
  @override
  _StreetSelectionScreenState createState() => _StreetSelectionScreenState();
}

class _StreetSelectionScreenState extends State<StreetSelectionScreen> {
  String? selectedStreet;
  String? selectedHouse;
  List<String> streets = [];
  Map<String, List<String>> streetHouses = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCsvData();
  }

  Future<void> loadCsvData() async {
    try {
      final response = await http.get(Uri.parse('https://wiki.serve.com.ua/source/filtered_data.csv'));
      if (response.statusCode == 200) {
        List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(response.body);

        Map<String, List<String>> streets = {};

        for (var row in rowsAsListOfValues) {
          String streetName = row[6].toString().trim();
          List<String> houses = row[7].toString().split(',');

          streets.putIfAbsent(streetName, () => []).addAll(houses.map((house) => house.trim()));
        }

        // ... (сортировка и обновление состояния)
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выбор улицы и дома'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: <Widget>[
          DropdownButton<String>(
            value: selectedStreet,
            hint: Text('Выберите улицу'),
            onChanged: (String? newValue) {
              setState(() {
                selectedStreet = newValue;
                selectedHouse = null;
              });
            },
            items: streets.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          if (selectedStreet != null)
            DropdownButton<String>(
              value: selectedHouse,
              hint: Text('Выберите номер дома'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedHouse = newValue;
                });
              },
              items: streetHouses[selectedStreet]?.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
