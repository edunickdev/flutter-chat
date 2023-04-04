import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _submitAuthForm(
      String email, String password, String username, bool islogin, BuildContext context) async {
    UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      if (islogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        
        FirebaseFirestore.instance.doc(userCredential.user!.uid).set({
          'username': username,
          'email': email
        });
      }
    } on PlatformException catch (error) {
      var message = 'An error ocurred, please check your credentials.';
      if (error.message != null) {
        message = error.message!;
      }
      Scaffold.of(context).showBottomSheet((context) => Text(message),
          backgroundColor: Theme.of(context).primaryColor);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading
      ),
    );
  }
}
