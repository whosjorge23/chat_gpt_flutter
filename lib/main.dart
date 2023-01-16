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
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value == null) {
                return 'Please enter a name';
              }
              return null;
            },
            onSaved: (value) => _name = value!,
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
                var uri = Uri.parse('https://api.nationalize.io/?name=$_name');
                var response = await http.get(uri);
                var jsonResponse = jsonDecode(response.body);
                var country = jsonResponse['country'][0];
                _result =
                    'Country: ${country['country_id']}, Probability: ${country['probability']}';
                setState(() {});
              }
            },
            child: Text('Submit'),
          ),
          Text(_result),
        ],
      ),
    );
  }
}
