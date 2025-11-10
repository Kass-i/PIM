import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn.instance;
  bool _isInitialized = false;

  User? _user;

  AuthProvider() {
    _firebaseAuth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  User? get currentUser => _user;

  Future<void> initSignIn() async {
    if (!_isInitialized) {
      await _googleSignIn.initialize();
    }
    _isInitialized = true;
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await initSignIn();
      final googleUser = await _googleSignIn.authenticate();

      final auth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(idToken: auth.idToken);
      return await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      log('Failed to sign in: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      log('Failed to sign out: $e');
    }
  }
}
