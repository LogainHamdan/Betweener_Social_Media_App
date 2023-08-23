import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/controllers/user_controller.dart';
import 'package:tt9_betweener_challenge/views_features/onbording/onbording_view.dart';

import '../../core/utils/constants.dart';
import '../../models/link.dart';
import '../../models/user.dart';
import '../links/add_link_view.dart';
import '../search/search_view.dart';

class HomeView extends StatefulWidget {
  static String id = '/homeView';

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<User>
      user; //late because we not decompose the data yet ! and the same type of data returned of getLocalUser func.
  late Future<List<Link>> links;

  @override
  void initState() {
    super.initState();
    user =
        getLocalUser(); //her we call the function and assigned it to the same type of data Future <user>
    links = getLinks(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          backgroundColor: Color(0xff2D2B4E),
          centerTitle: true,
          title: const Text(
            'Betweener',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SearchView.id);
                  },
                  icon: Icon(
                    Icons.search,
                    size: 40,
                    color: Color(0xff2D2B4E),
                  )),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.qr_code,
                  color: Color(0xff2D2B4E),
                  size: 40,
                ),
              )
            ],
          ),
        ),
        FutureBuilder(
          future: user,
          //her instead use fun getLocalUser and each time we rebuild it will turned on again we keep the data and such as use then her
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 30),
                child: Center(
                  child: Text(
                    'Welcome, ${snapshot.data?.user?.name}!',
                    style: const TextStyle(
                        color: Color(0xff2D2B4E),
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
        SizedBox(
          height: 16,
        ),
        Center(
          child: Container(
            child: Image(image: AssetImage('assets/imgs/qr.png')),
            height: 250,
            width: 260,
          ),
        ),
        SizedBox(
          height: 65,
        ),
        FutureBuilder(
          future: links,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: 130,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.all(12),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (snapshot.data!.isNotEmpty) {
                            return Container(
                              height: 90,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: const Color(0x8CDED63B),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Text(
                                      '${snapshot.data?[index].title}',
                                      style: const TextStyle(
                                          color: Color(0xA0342213),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Text(
                                      '${snapshot.data?[index].link}',
                                      style: const TextStyle(
                                          color: Color(0xA0342213),
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          Container(
                            height: 90,
                            width: 150,
                            decoration: BoxDecoration(
                                color: const Color(0x8CDED63B),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Color(0xff2D2B4E),
                                ),
                                Text('Add link')
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 25,
                          );
                        },
                        itemCount: snapshot.data!.length,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Container(
                          height: 105,
                          width: 100,
                          decoration: BoxDecoration(
                              color: kLinksColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 45,
                                  color: Color(0xff2D2B4E),
                                ),
                                Text(
                                  'Add link',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff2D2B4E),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, AddLinkView.id);
                        },
                        overlayColor:
                            MaterialStateProperty.all(Colors.grey.shade500),
                        autofocus: true,
                        highlightColor: Colors.grey,
                      ),
                    )
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return CircularProgressIndicator();
          },
        ),
      ],
    );
  }
}
