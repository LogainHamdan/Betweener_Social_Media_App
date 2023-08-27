import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tt9_betweener_challenge/controllers/follow_controller.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/controllers/user_controller.dart';
import 'package:tt9_betweener_challenge/models/link.dart';
import 'package:tt9_betweener_challenge/views_features/follow/follow_list_views.dart';

import '../../core/utils/constants.dart';
import '../../models/follow.dart';
import '../../models/user.dart';
import '../edit_profile_info.dart';
import '../links/add_link_view.dart';
import '../links/edit_link_view.dart';
import '../map_view.dart';

class ProfileView extends StatefulWidget {
  static String id = '/profileView';

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<List<Link>> links;
  late Future<User> user;
  late Future<FollowModel> follows;

  //ليش ما عرفتها تحت؟
  // ؟؟عشان رح اضل اغير علييها بكل رنة بكل state

  @override
  void initState() {
    user = getLocalUser();

    follows = getFollow();
    links = getLinks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppBar(
          backgroundColor: Color(0xff2D2B4E),
          centerTitle: true,
          title: const Text(
            'Betweener',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Profile",
          style: TextStyle(
            color: Color(0xff2D2B4E),
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat', // You can set your preferred font here
            letterSpacing: 1.2, // Adjust letter spacing for better readability
            shadows: [
              Shadow(
                color:
                    Colors.grey.withOpacity(0.3), // Add a subtle shadow effect
                offset: Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),

        ///personal info Card
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 20, right: 12, top: 12, bottom: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xff2D2B4E)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Icon(Icons.face, size: 45, color: Color(0xff2D2B4E)),
                  radius: 45.r,
                ),
                const SizedBox(width: 40),
                FutureBuilder<List<dynamic>>(
                    future: Future.wait([user, follows]),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapshot.data?[0].user?.name}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${snapshot.data?[0].user.email}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Text(
                                '${snapshot.data?[0].user.id}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FollowListView(
                                          followsCount:
                                              snapshot.data?[1].followersCount,
                                          follows: snapshot.data?[1].followers,
                                        ),
                                      ));
                                },
                                child: buildContainer(
                                    text:
                                        'followers: ${snapshot.data?[1].followersCount}'),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FollowListView(
                                          followsCount:
                                              snapshot.data?[1].followingCount,
                                          follows: snapshot.data?[1].following,
                                        ),
                                      ));
                                },
                                child: buildContainer(
                                    text:
                                        'following: ${snapshot.data?[1].followingCount}'),
                              ),
                            ],
                          ),
                        );
                      }
                      return const CircularProgressIndicator();
                    }),
                SizedBox(
                  width: 20,
                ),
                FutureBuilder(
                    future: user,
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: 30,
                            ),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileInfoView(
                                      name: '${snapshot.data?.user?.name}',
                                      email: '${snapshot.data?.user?.email}',
                                    ),
                                  ));
                              setState(() {
                                // snapshot.data?.user?.name =
                              });
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          IconButton(
                            // padding: EdgeInsets.all(15),
                            icon: Icon(
                              Icons.location_on_sharp,
                              color: Colors.red,
                              size: 40,
                            ),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pushNamed(context, GoogleMapView.id);
                            },
                          ),
                        ],
                      );
                    })
              ],
            ),
          ),
        ),
        SizedBox(
          height: 24.h,
        ),

        ///Links

        FutureBuilder(
          future: links,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Slidable(
                        startActionPane: ActionPane(
                          motion: const BehindMotion(),
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            SlidableAction(
                              onPressed: (context) => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditLinkView(
                                        linkId:
                                            snapshot.data![index].id.toString(),
                                        textTitle:
                                            '${snapshot.data![index].title}',
                                        textLink:
                                            '${snapshot.data![index].link}'),
                                  ),
                                ).then((_) {
                                  links = getLinks(context);
                                  setState(() {});
                                })
                              },
                              autoClose: true,
                              icon: Icons.edit,
                              backgroundColor: const Color(0xB6ECE673),
                              borderRadius: BorderRadius.circular(8),
                              foregroundColor: Colors.black,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SlidableAction(
                              onPressed: (context) =>
                                  deleteTheLink(snapshot.data![index].id)
                                      .then((value) {
                                links = getLinks(context);
                                setState(() {});
                              }),
                              borderRadius: BorderRadius.circular(8),
                              autoClose: true,
                              icon: Icons.delete,
                              backgroundColor: Color(0xF4FF364D),
                            ),
                          ],
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: kLinksColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data![index].title!,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Custom'),
                              ),
                              Text(
                                snapshot.data![index].link!,
                                style: const TextStyle(
                                    fontSize: 15, fontFamily: 'Custom'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: CircleAvatar(
                radius: 26.r,
                backgroundColor: const Color(0xff2D2B4E),
                child: InkWell(
                  onTap: () async {
                    await Navigator.pushNamed(context, AddLinkView.id)
                        .then((value) {
                      setState(() {
                        links = getLinks(context);
                      });
                    });
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 100.h,
        )
      ],
    );
  }

  //
  //   deleteTheLink(snap).then((checkData) {
  //     print(checkData);
  //     if (mounted && checkData == true) {
  //       Navigator.pop(context);
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text('Deleted successfully'),
  //         backgroundColor: Colors.green,
  //         behavior: SnackBarBehavior.floating,
  //         margin: EdgeInsets.all(12),
  //       ));
  //     }
  //   }).catchError((err) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(err.toString()),
  //       backgroundColor: Colors.red,
  //       behavior: SnackBarBehavior.floating,
  //       margin: EdgeInsets.all(12),
  //     ));
  //   });
  // }

  Container buildContainer({required String text}) {
    return Container(
      height: 33,
      width: 100,
      padding: EdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color(0xffFFD465),
          borderRadius: BorderRadius.circular(8)),
      child: Text(text),
    );
  }
}
