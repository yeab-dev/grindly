import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/wakatime_user.dart';
import 'package:grindly/shared/user_profile/data/models/social_media_account.model.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart';

class UserModel extends Equatable {
  final String uid;
  final String email;
  final DateTime createdAt;
  final String displayName;
  final String? bio;
  final String? photoUrl;
  final WakatimeUser? wakatimeAccount;
  final List<SocialMediaAccountModel>? socialMediaAccounts;

  const UserModel({
    required this.uid,
    required this.email,
    required this.createdAt,
    required this.displayName,
    this.bio,
    this.photoUrl,
    this.wakatimeAccount,
    this.socialMediaAccounts,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    final createdAtRaw = map['created_at'];
    return UserModel(
      wakatimeAccount: map['wakatime_account'],
      uid: map['uid'],
      email: map['email'],
      displayName: map['display_name'],
      bio: map['bio'],
      photoUrl: map['photo_url'] as String?,
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
      'display_name': displayName,
      'photo_url': photoUrl,
      'bio': bio,
      'created_at': Timestamp.fromDate(createdAt),
      'social_media_accounts': socialMediaAccounts?.map((account) {
        return account.toMap();
      }).toList(),
    };
  }

  User toEntity() {
    return User(
      uid: uid,
      email: email,
      displayName: displayName,
      createdAt: createdAt,
      bio: bio,
      photoUrl: photoUrl,
      wakatimeAccount: wakatimeAccount,
      socialMediaAccounts: socialMediaAccounts
          ?.map((element) => element.toEntity())
          .toList(),
    );
  }

  UserModel copyWith({
    String? bio,
    String? email,
    String? displayName,
    String? username,
    String? photoUrl,
    DateTime? createdAt,
    WakatimeUser? wakatimeAccount,
    List<SocialMediaAccountModel>? socialMediaAccounts,
  }) {
    return UserModel(
      uid: uid,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      socialMediaAccounts: socialMediaAccounts ?? this.socialMediaAccounts,
      wakatimeAccount: wakatimeAccount ?? this.wakatimeAccount,
    );
  }

  @override
  List<Object?> get props => [uid];
}
