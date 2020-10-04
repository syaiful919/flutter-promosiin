import 'package:base_project/model/response/auth_response_model.dart';
import 'package:base_project/utils/custom_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User getUser() => _auth.currentUser;

  Future<AuthResponseModel> signUp({
    @required String email,
    @required String password,
  }) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      return AuthResponseModel(userId: user.uid);
    } on FirebaseAuthException catch (e) {
      print(">>> firebase error: $e");

      throw BadRequestException(e.toString().split(',')[1].trim());
    } catch (e) {
      print(">>> error: $e");
    }
  }

  Future<AuthResponseModel> signIn({
    @required String email,
    @required String password,
  }) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = result.user;
      return AuthResponseModel(userId: user.uid);
    } on FirebaseAuthException catch (e) {
      print(">>> firebase error: $e");

      throw UnauthorizedException(e.toString().split(',')[1].trim());
    } catch (e) {
      print(">>> error: $e");
    }
  }

  Future<void> signOut() async => await _auth.signOut();

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(">>> error $e");
    }
  }
}
