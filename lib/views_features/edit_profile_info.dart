import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tt9_betweener_challenge/views_features/widgets/custom_text_form_field.dart';
import 'package:tt9_betweener_challenge/views_features/widgets/my-button_widget.dart';

import '../core/utils/assets.dart';

class ProfileInfoView extends StatefulWidget {
  late String name;
  late String email;

  ProfileInfoView({super.key, required this.name, required this.email});

  @override
  State<ProfileInfoView> createState() => _ProfileInfoViewState();
}

class _ProfileInfoViewState extends State<ProfileInfoView> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit profile information"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height,
            child: Form(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  const CircleAvatar(
                    radius: 75,
                    child: Icon(Icons.face, size: 80, color: Color(0xff2D2B4E)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    controller: nameController,
                    label: 'Name',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    label: 'Email',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    controller: phoneController,
                    label: 'Phone Number',
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  MyButton(
                    text: 'Update',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
