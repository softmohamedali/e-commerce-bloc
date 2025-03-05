import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/constant/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entites/signup_pargms.dart';
import '../../domain/usecase/sign_in_usecase.dart';
import '../../domain/usecase/sign_up_usecase.dart';

class FirebaseAuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp(SignUpParams params) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: params.email,
      password: params.password,
    ).then((value) {
      params.id=const Uuid().v1();
      setUserDoc(params.toJson());
    });
  }

  Future<void> login(SignInParams params) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<void> setUserDoc(Map<String,dynamic> map)async{
    DocumentReference userRef=_firestore.collection(FirebaseCons.userColl)
        .doc(map["id"]);
    userRef.set(map);
  }
  Future<void> updateUserDoc(Map<String,dynamic> map)async{
    DocumentReference userRef=_firestore.collection(FirebaseCons.userColl)
        .doc(map["id"]);
    userRef.update(map);
  }

}