import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/controllers/user_controller.dart';
import 'package:tt9_betweener_challenge/models/link.dart';

import '../../core/utils/constants.dart';
import '../../models/user.dart';
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

  //ليش ما عرفتها تحت؟
  // ؟؟عشان رح اضل اغير علييها بكل رنة بكل state

  @override
  void initState() {
    user = getLocalUser();
    links = getLinks(context);
    super.initState();
  }

  void deleteLink(String? title, String? link) {
    final body = {'title': title, 'link': link};
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Profile",
            style: TextStyle(
                color: Color(0xff2D2B4E),
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 12.h,
          ),

          ///personal info Card
          Container(
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
                SizedBox(width: 40),
                FutureBuilder(
                    future: user,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${snapshot.data?.user?.name}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${snapshot.data?.user?.email}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                            Text(
                              '${snapshot.data?.user?.id}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            buildContainer(text: "follower 203"),
                            SizedBox(
                              height: 8,
                            ),
                            buildContainer(text: 'following 100'),
                          ],
                        );
                      }
                      return const CircularProgressIndicator();
                    }),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 30,
                      ),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pushNamed(context, GoogleMapView.id);
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
                )
              ],
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
                                          linkId: snapshot.data![index].id
                                              .toString(),
                                          textTitle:
                                              snapshot.data![index].title,
                                          textLink: snapshot.data![index].link),
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
              CircleAvatar(
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
            ],
          ),
          SizedBox(
            height: 100.h,
          )
        ],
      ),
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
