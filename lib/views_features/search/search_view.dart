import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/follow_controller.dart';
import 'package:tt9_betweener_challenge/controllers/search_controller.dart';
import 'package:tt9_betweener_challenge/models/follow.dart';
import 'package:tt9_betweener_challenge/views_features/profile/profile_view.dart';

import '../../core/utils/constants.dart';
import '../../models/user.dart';
import '../widgets/follow_unfollow_button.dart';

class SearchView extends StatefulWidget {
  static String id = '/searchView';

  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late TextEditingController nameController;
  List<UserClass> users = [];
  late FollowModel followModel;

  @override
  void initState() {
    getFollow().then((value) {
      followModel = value;
      setState(() {});
    });
    nameController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  submitSearch(String name) {
    Map<String, dynamic> body = {'name': name};
    searchByName(body).then((value) {
      users = value;
      setState(() {});
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No users'),
        backgroundColor: Color(0xff2D2B4E),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 70.0, left: 20, right: 20),
          child: Column(
            children: [
              TextField(
                cursorColor: const Color(0xff2D2B4E),
                onChanged: (value) {
                  submitSearch(value);
                },
                cursorHeight: 25,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  hintText: 'Enter user name',
                  suffix: Icon(
                    Icons.person,
                    shadows: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(3, 3),
                          blurRadius: 5)
                    ],
                    size: 30,
                    color: Color(0xff2D2B4E),
                  ),
                ),
                controller: nameController,
                autofocus: true,
              ),
              nameController.text.isNotEmpty
                  ? (users.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: users.length,
                              itemBuilder: (context, index) {
                                if (users.isNotEmpty) {
                                  return Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: kLinksColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                users[index].name!,
                                                style: const TextStyle(
                                                  color: Color(0xff2D2B4E),
                                                  // Assuming you want the text to be white
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              FollowUnfollowButton(
                                                isFollowed: followModel
                                                        .following!
                                                        .where((user) {
                                                  return user
                                                          .id == //بتلرجعلي قيمة بوليانية واللي يعني هل انا متابعاه ولا لاء !!
                                                      users[index].id;
                                                }).isNotEmpty
                                                    ? true
                                                    : false,
                                                followFunction: () {
                                                  addFollow({
                                                    'followee_id':
                                                        users[index].id
                                                  }).then((checkFollowed) {
                                                    if (checkFollowed) {
                                                      //تمت المتابعة بنجاح
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                        content: Text(
                                                            'Followed Successfully'),
                                                        backgroundColor:
                                                            Colors.black45,
                                                      ));
                                                      getFollow().then((value) {
                                                        followModel = value;
                                                        setState(() {});
                                                      });
                                                    }
                                                  }).catchError((err) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(err),
                                                      backgroundColor:
                                                          Colors.red,
                                                    ));
                                                  });
                                                },
                                                unfollowFunction: () {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ));
                                }
                              }),
                        )
                      : AlertDialog(
                          backgroundColor: kLinksColor,
                          contentPadding: EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          titlePadding: EdgeInsets.all(0),
                          content: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.cancel_outlined,
                                size: 45,
                                color: Color(
                                    0xff2D2B4E), // Assuming you want the icon to be white
                              ),
                              SizedBox(height: 10),
                              Text(
                                'No users',
                                style: TextStyle(
                                  color: Color(0xff2D2B4E),
                                  // Assuming you want the text to be white
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ))
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
