import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';
import '../../models/follow.dart';

class FollowListView extends StatefulWidget {
  static const id = "FollowListView";
  late int? followsCount;
  late List<Follow>? follows;
  FollowListView({super.key, this.followsCount, this.follows});

  @override
  State<FollowListView> createState() => _FollowListViewState();
}

class _FollowListViewState extends State<FollowListView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Follow List'),
          clipBehavior: Clip.none,
          backgroundColor: kPrimaryColor,
          shadowColor: Colors.white,
          centerTitle: true,
        ),
        body: widget.follows!.isNotEmpty
            ? ListView.builder(
                itemCount: widget.follows!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kLinksColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.follows![index].id!}',
                              style: const TextStyle(
                                color: Color(
                                    0xff2D2B4E), // Assuming you want the text to be white
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.follows![index].name!,
                              style: const TextStyle(
                                color: Color(
                                    0xff2D2B4E), // Assuming you want the text to be white
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.follows![index].email!,
                              style: const TextStyle(
                                color: Color(
                                    0xff2D2B4E), // Assuming you want the text to be white
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : AlertDialog(
                elevation: 10,
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
                        color: Color(
                            0xff2D2B4E), // Assuming you want the text to be white
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
