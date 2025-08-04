import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends Equatable {
  final String uid;
  final String email;
  final String displayName;
  final String? username;
  final String? photoUrl;
  final DateTime createdAt;

  const UserModel({
    this.photoUrl,
    this.username,
    required this.displayName,
    required this.uid,
    required this.email,
    required this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    final createdAtRaw = map['createdAt'];
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],
      username: map['username'] as String?,
      photoUrl: map['photoUrl'] as String?,
      createdAt: createdAtRaw is Timestamp
          ? createdAtRaw.toDate()
          : DateTime.parse(createdAtRaw),
    );
  }

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      displayName: user.displayName ?? '',
      uid: user.uid,
      email: user.email ?? '',
      photoUrl: user.photoURL,
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'username': username,
      'photoUrl': photoUrl,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  UserModel copyWith({
    String? email,
    String? displayName,
    String? username,
    String? photoUrl,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [uid];
}
