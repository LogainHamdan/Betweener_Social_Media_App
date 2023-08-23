import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  static String id = '/searchView';

  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late TextEditingController nameController;


  @override
  void initState() {
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void submitSearch() {


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
                onChanged: (){submitSearch},
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
                onTap: () {},
              ),
              ElevatedButton(
                autofocus: false,
                clipBehavior: Clip.none,
                onPressed: () {},
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xff2D2B4E)),
                ),
                child: const Text(
                  'Search',
                  style: TextStyle(fontSize: 25),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
