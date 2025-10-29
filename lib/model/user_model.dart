import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final DocumentReference reference;
  final String id;
  final String name;
  final String email;
  final String password;
  final DateTime createAt;

  UserModel({
    required this.reference,
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.createAt,
  });

  // Convert UserModel → Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'createAt': createAt,
    };
  }

  // Convert Firestore → UserModel
  factory UserModel.fromMap(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      reference: doc.reference,
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      createAt: (data['createAt'] as Timestamp).toDate(),
    );
  }
}
