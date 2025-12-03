import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/features/friends/presentation/cubit/friends_cubit.dart';
import 'package:grindly/features/friends/presentation/widgets/friend_info_tile.dart';
import 'package:grindly/features/friends/presentation/widgets/friends_filter_widget.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart';

class FriendsListPage extends StatefulWidget {
  final User currentUser;
  const FriendsListPage({super.key, required this.currentUser});

  @override
  State<FriendsListPage> createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onTabPressed(int index) {
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(title: Text('Friends'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.5,
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FriendsFilterWidget(
                    label: 'following',
                    selected: _currentIndex == 0,
                    onTap: () => _onTabPressed(0),
                  ),
                  Spacer(),
                  FriendsFilterWidget(
                    label: 'followers',
                    selected: _currentIndex == 1,
                    onTap: () => _onTabPressed(1),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.85,
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
                children: [
                  BlocConsumer<FriendsCubit, FriendsState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is FriendsStateSuccess) {
                        return ListView.builder(
                          itemCount: _currentIndex == 0
                              ? state.following?.length ?? 0
                              : state.followers?.length ?? 0,
                          itemBuilder: (context, index) {
                            if (state.following != null &&
                                state.following!.isNotEmpty) {
                              return Padding(
                                padding: EdgeInsets.only(left: width * 0.05),
                                child: FriendInfoTile(
                                  currentUser: widget.currentUser,
                                  userID: state.following![index].uid,
                                  displayName:
                                      state.following![index].displayName,
                                  photoUrl: state.following![index].photoUrl!,
                                  followsThem: widget.currentUser.following
                                      .contains(state.following![index].uid),
                                  totalHours:
                                      state
                                          .following![index]
                                          .wakatimeAccount
                                          ?.totalTime ??
                                      Duration(),
                                ),
                              );
                            }
                            return SizedBox.shrink();
                          },
                        );
                      } else if (state is FriendsStateInProgress) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return SizedBox.shrink();
                    },
                  ),
                  BlocConsumer<FriendsCubit, FriendsState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is FriendsStateSuccess) {
                        return ListView.builder(
                          itemCount: state.followers?.length ?? 0,
                          itemBuilder: (context, index) {
                            if (state.followers != null &&
                                state.followers!.isNotEmpty) {
                              return Padding(
                                padding: EdgeInsets.only(left: width * 0.05),
                                child: FriendInfoTile(
                                  displayName:
                                      state.followers![index].displayName,
                                  currentUser: widget.currentUser,
                                  userID: state.followers![index].uid,
                                  photoUrl: state.followers![index].photoUrl!,
                                  followsThem: widget.currentUser.following
                                      .contains(state.followers![index].uid),
                                  totalHours:
                                      state
                                          .followers![index]
                                          .wakatimeAccount
                                          ?.totalTime ??
                                      Duration(),
                                ),
                              );
                            }
                            return SizedBox.shrink();
                          },
                        );
                      } else if (state is FriendsStateInProgress) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
