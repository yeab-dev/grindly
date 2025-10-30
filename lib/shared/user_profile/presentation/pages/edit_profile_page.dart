import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/shared/user_profile/presentation/cubit/user_profile_cubit.dart';
import 'package:grindly/shared/user_profile/presentation/widgets/profile_picture_widget.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    final formKey = GlobalKey<FormState>();
    TextEditingController displayNameController = TextEditingController();
    TextEditingController bioController = TextEditingController();
    TextEditingController xController = TextEditingController();
    TextEditingController telegramController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height * 0.07),
                  child: ProfilePictureWidget(
                    imgSource:
                        "https://lh3.googleusercontent.com/a/ACg8ocKDOtcg3QQGKxkX-m0q4h-O7lERp21F0J1o-l4YFPBBCQ-jZ_w=s96-c",
                  ),
                ),
                Positioned(
                  bottom: -(height * 0.012),
                  right: width * 0.27,
                  child: IconButton(
                    onPressed: () {},
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
              child: Text('Yeabsera', style: theme.textTheme.headlineSmall),
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
                        labelText: 'Telegram',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: theme.colorScheme.onSurface.withAlpha(80),
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
                        labelText: 'Telegram',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: theme.colorScheme.onSurface.withAlpha(50),
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
                      padding: EdgeInsets.symmetric(vertical: height * 0.02),
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
                            color: theme.colorScheme.onSurface.withAlpha(50),
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
                              color: theme.colorScheme.onSurface.withAlpha(50),
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
                          displayName: displayNameController.text,
                          bio: bioController.text,
                          xLink: xController.text,
                          telegramLink: telegramController.text,
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
      ),
    );
  }
}
