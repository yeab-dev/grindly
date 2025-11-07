import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/core/locator.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart'
    as grindly;
import 'package:grindly/shared/user_profile/presentation/cubit/user_profile_cubit.dart';
import 'package:grindly/shared/user_profile/presentation/widgets/profile_picture_widget.dart';

class EditProfilePage extends StatefulWidget {
  final grindly.User user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  grindly.PhotoSource? photoSource;

  final formKey = GlobalKey<FormState>();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController xController = TextEditingController();
  TextEditingController telegramController = TextEditingController();

  @override
  void initState() {
    final user = widget.user;
    displayNameController.text = user.displayName;
    bioController.text = user.bio ?? "";
    xController.text = user.socialMediaAccounts.isEmpty
        ? "https://x.com/"
        : user.socialMediaAccounts.firstWhere((account) {
            return account.platformName == "X";
          }).platformName;
    telegramController.text = user.socialMediaAccounts.isEmpty
        ? "https://t.me/"
        : user.socialMediaAccounts.firstWhere((account) {
            return account.platformName == "Telegram";
          }).platformName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return BlocConsumer<UserProfileCubit, UserProfileState>(
      listener: (context, state) {
        if (state is UserProfileFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state is UserProfileSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('done', style: theme.textTheme.bodyLarge),
              backgroundColor: theme.colorScheme.primaryContainer,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is UserProfileSuccess) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.07),
                      child: Builder(
                        builder: (_) {
                          final imgSourceString = photoSource == null
                              ? (widget.user.photoUrl ?? '')
                              : photoSource == grindly.PhotoSource.google
                              ? (getIt<FirebaseAuth>().currentUser?.photoURL ??
                                    '')
                              : (state.user.wakatimeAccount?.photoUrl ??
                                    widget.user.photoUrl ??
                                    '');
                          return ProfilePictureWidget(
                            imgSource: imgSourceString,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: -(height * 0.012),
                      right: width * 0.27,
                      child: IconButton(
                        onPressed: () {
                          showBottomSheet(
                            showDragHandle: true,
                            context: context,
                            builder: ((context) {
                              return Container(
                                height: height * 0.13,
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: height * 0.01,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            displayNameController =
                                                displayNameController;
                                            photoSource =
                                                grindly.PhotoSource.google;
                                          });
                                        },
                                        child: Text(
                                          'use my google account profile picture',
                                          style: theme.textTheme.labelLarge
                                              ?.copyWith(
                                                fontSize: 17,
                                                color:
                                                    theme.colorScheme.primary,
                                              ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            photoSource =
                                                grindly.PhotoSource.wakatime;
                                          });
                                        },
                                        child: Text(
                                          'use wakatime profile picture',
                                          style: theme.textTheme.labelLarge
                                              ?.copyWith(
                                                fontSize: 17,
                                                color:
                                                    theme.colorScheme.primary,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                        icon: Icon(
                          Icons.photo_camera_rounded,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.01),
                  child: Text(
                    state.user.displayName,
                    style: theme.textTheme.headlineSmall,
                  ),
                ),

                Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.06,
                      vertical: height * 0.02,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: displayNameController,
                          decoration: InputDecoration(
                            labelText: 'name',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: theme.colorScheme.onSurface.withAlpha(
                                  80,
                                ),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.015),
                        TextFormField(
                          controller: bioController,
                          decoration: InputDecoration(
                            labelText: 'bio',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: theme.colorScheme.onSurface.withAlpha(
                                  50,
                                ),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                          maxLines: 3,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.02,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Social links',
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: xController,
                          decoration: InputDecoration(
                            labelText: 'X',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: theme.colorScheme.onSurface.withAlpha(
                                  50,
                                ),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.015),
                          child: TextFormField(
                            controller: telegramController,
                            decoration: InputDecoration(
                              labelText: 'Telegram',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: theme.colorScheme.onSurface.withAlpha(
                                    50,
                                  ),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.05),
                  child: BlocBuilder<UserProfileCubit, UserProfileState>(
                    builder: (context, state) {
                      if (state is UserProfileInProgress) {
                        return SizedBox(
                          height: height * 0.06,
                          width: height * 0.06,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      return SizedBox(
                        height: height * 0.055,
                        width: width * 0.5,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<UserProfileCubit>().updateUser(
                              photoSrc: photoSource,
                              previous: (state as UserProfileSuccess).user,
                              displayName: displayNameController.text.isEmpty
                                  ? null
                                  : displayNameController.text,
                              bio: bioController.text.isEmpty
                                  ? null
                                  : bioController.text,
                              xLink: xController.text == "https://x.com/"
                                  ? null
                                  : xController.text,
                              telegramLink:
                                  telegramController.text == "https://t.me/"
                                  ? null
                                  : telegramController.text,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                          ),
                          child: Text('Save'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is UserProfileInProgress) {
          return Center(child: CircularProgressIndicator());
        }
        return SizedBox.shrink();
      },
    );
  }
}
