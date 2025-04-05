import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();
  static final instance = AuthService._();
  String? verificationId; // Declare verificationId here
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> sendPhoneVerificationCode(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Handle auto-verification of the phone number.
        // You can proceed with updating the user profile or any other logic.
      },
      verificationFailed: (FirebaseAuthException authException) {
        // Handle the verification failure (e.g., invalid phone number).
        print('Phone number verification failed: ${authException.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        // Store the verificationId in a secure place to be used later.
        // You may want to store it in your controller or another secure location.
        // For simplicity, you can use the instance variable of AuthService.
        instance.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle timeout
      },
    );
  }

  Future<bool> signInWithPhoneCredential(String code) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: instance.verificationId!,
        smsCode: code,
      );

      // Use the credential to sign in the user or update the user's phone number.
      await _auth.signInWithCredential(credential);
      print(credential);

      return true;
    } catch (e) {
      // Handle verification failure.
      print('Phone number verification failed: $e');
      rethrow;
    }
  }
}
