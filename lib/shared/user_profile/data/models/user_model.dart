import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/wakatime_user.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart';

class UserModel extends Equatable {
  final String uid;
  final String email;
  final DateTime createdAt;
  final String displayName;
  final String? username;
  final String? photoUrl;
  final WakatimeUser? wakatimeAccount;

  const UserModel({
    required this.uid,
    required this.email,
    required this.createdAt,
    required this.displayName,
    this.photoUrl,
    this.username,
    this.wakatimeAccount,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    final createdAtRaw = map['createdAt'];
    return UserModel(
      wakatimeAccount: map['wakatimeAccount'],
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

  factory UserModel.fromFirebaseUser(firebase_auth.User user) {
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

  User toEntity() {
    return User(
      wakatimeAccount: wakatimeAccount!,
      uid: uid,
      email: email,
      displayName: displayName,
      createdAt: createdAt,
      username: username,
      photoUrl: photoUrl,
    );
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
