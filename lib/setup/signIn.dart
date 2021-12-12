import 'package:firebase_integration/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
                if (input!.isEmpty) {
                  return "Please type an email";
                }
              },
              onChanged: (input) {
                setState(() {
                  _email = input;
                });
              },
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              validator: (input) {
                if (input!.length < 6) {
                  return "your password needs to be atlest 6 characters";
                }
              },
              onChanged: (input)  {
                 setState(() {
                   _password = input;
                 });
              },
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            RaisedButton(
              color: Colors.black,
              onPressed: signIn,
              child: Text('Sign in'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formkey.currentState;
    if (formState!.validate()) {
      formState.save();

      try {
        //var FirebaseUser;
        final FirebaseUser= await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (Context) => Home()));
      } catch (e) {
        print(e);
      }
    }
  }
}
