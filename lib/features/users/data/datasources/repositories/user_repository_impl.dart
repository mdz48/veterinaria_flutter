import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:veterinaria/features/users/data/datasources/remote/mapper/user_mapper.dart';
import 'package:veterinaria/features/users/domain/entities/user.dart';
import 'package:veterinaria/features/users/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final firebase_auth.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  UserRepositoryImpl({
    required firebase_auth.FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : _auth = auth,
       _firestore = firestore;

  @override
  Future<User> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;
    final doc = await _firestore.collection('users').doc(uid).get();

    final model = UserModelMapper.fromMap({'id': uid, ...doc.data() ?? {}});
    return model.toEntity();
  }

  @override
  Future<bool> register(String email, String password, String name, String lastName) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;
    await _firestore.collection('users').doc(uid).set({
      'email': email,
      'name': name,
      'lastName': lastName,
      'role': 'client',
    });

    return true;
  }
}
