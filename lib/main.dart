import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  String _errorMessage = "";

  void _submit() async {
    // if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
    //   setState(() {
    //     _errorMessage = "Il nome utente e la password sono obbligatori";
    //   });
    //   return;
    // }
    // setState(() {
    //   _errorMessage = "";
    // });
    // // invia le credenziali al tuo server per l'autenticazione
    // // e gestisci la risposta
    // final response =
    //     await login(_usernameController.text, _passwordController.text);
    // if (response.statusCode == 200) {
    //   // autenticazione riuscita
    //   // reindirizza alla schermata principale dell'app
    //   Navigator.of(context).pushReplacementNamed("/home");
    // } else {
    //   setState(() {
    //     _errorMessage = "Autenticazione fallita";
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_errorMessage != null)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Nome Utente"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: _obscureText,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text("Accedi"),
            ),
          ],
        ),
      ),
    );
  }
}
