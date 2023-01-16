import 'package:chat_gpt_flutter/model/country.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nationalize Name',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nationalize Name'),
        ),
        body: NationalizeNameForm(),
      ),
    );
  }
}

class NationalizeNameForm extends StatefulWidget {
  @override
  _NationalizeNameFormState createState() => _NationalizeNameFormState();
}

class _NationalizeNameFormState extends State<NationalizeNameForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  List<Country> _countries = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null) {
                  return 'Please enter a name';
                }
                return null;
              },
              onSaved: (value) => _name = value!,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
                var uri = Uri.parse('https://api.nationalize.io/?name=$_name');
                var response = await http.get(uri);
                var jsonResponse = jsonDecode(response.body);
                _countries = (jsonResponse['country'] as List)
                    .map((e) => Country.fromJson(e))
                    .toList();
                setState(() {});
              }
            },
            child: Text('Submit'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _countries.length,
              itemBuilder: (context, index) {
                var country = _countries[index];
                return ListTile(
                  title: Text(
                      'Country: ${countriesDictionary[country.country_id] ?? ""}'),
                  subtitle: Text(
                      'Probability: ${(country.probability * 100).toStringAsFixed(2)}%'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
