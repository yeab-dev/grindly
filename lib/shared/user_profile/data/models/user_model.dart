import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:grindly/features/wakatime/wakatime_profile/data/models/country_model.dart';
import 'package:grindly/features/wakatime/wakatime_profile/data/models/wakatime_user_model.dart';
import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/wakatime_user.dart';
import 'package:grindly/shared/user_profile/data/models/social_media_account.model.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart';

class UserModel extends Equatable {
  final String uid;
  final String email;
  final DateTime createdAt;
  final String displayName;
  final WakatimeUser? wakatimeAccount;
  final String? bio;
  final String? photoUrl;
  final String? wakatimeId;
  final CountryModel? countryModel;
  final String? wakatimeProfilePictureUrl;
  final List<SocialMediaAccountModel> socialMediaAccounts;

  const UserModel({
    required this.uid,
    required this.email,
    required this.createdAt,
    required this.displayName,
    this.bio,
    this.photoUrl,
    required this.socialMediaAccounts,
    this.wakatimeId,
    this.countryModel,
    this.wakatimeProfilePictureUrl,
    this.wakatimeAccount,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    final createdAtRaw = map['created_at'];
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      displayName: map['display_name'],
      bio: map['bio'],
      photoUrl: map['photo_url'] as String?,
      socialMediaAccounts: (map['social_media_accounts'] as List<dynamic>)
          .map((element) => SocialMediaAccountModel.fromMap(map: element))
          .toList(),
      createdAt: createdAtRaw is Timestamp
          ? createdAtRaw.toDate()
          : DateTime.parse(createdAtRaw),
      wakatimeProfilePictureUrl: map['wakatime_profile_picture_url'],
      wakatimeId: map['wakatime_id'],
      countryModel: map.containsKey('country')
          ? map['country'] != null
                ? CountryModel.fromJson(map['country'])
                : null
          : null,
      wakatimeAccount: WakatimeUserModel.fromMap(map).toEntity(),
    );
  }

  factory UserModel.fromFirebaseUser(firebase_auth.User user) {
    return UserModel(
      socialMediaAccounts: [],
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
      'social_media_accounts': socialMediaAccounts.map((account) {
        return account.toMap();
      }).toList(),
      'wakatime_profile_picture_url': wakatimeAccount?.photoUrl,
      'wakatime_id': wakatimeAccount?.id,
      'country': wakatimeAccount?.country != null
          ? {
              "country": wakatimeAccount!.country!.countryName,
              "country_code": wakatimeAccount!.country!.countryCode,
            }
          : null,
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
      socialMediaAccounts: socialMediaAccounts
          .map((element) => element.toEntity())
          .toList(),
      wakatimeProfilePictureUrl: wakatimeProfilePictureUrl,
      wakatimeId: wakatimeId,
      country: countryModel?.toEntity(),
      wakatimeAccount: wakatimeAccount,
    );
  }

  UserModel copyWith({
    String? bio,
    String? displayName,
    String? photoUrl,
    List<SocialMediaAccountModel>? socialMediaAccounts,
    WakatimeUser? wakatimeAccount,
  }) {
    return UserModel(
      uid: uid,
      bio: bio ?? this.bio,
      email: email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt,
      socialMediaAccounts: socialMediaAccounts ?? this.socialMediaAccounts,
      wakatimeId: wakatimeId,
      wakatimeProfilePictureUrl: wakatimeProfilePictureUrl,
      countryModel: countryModel,
      wakatimeAccount: wakatimeAccount ?? this.wakatimeAccount,
    );
  }

  @override
  List<Object?> get props => [uid];
}
