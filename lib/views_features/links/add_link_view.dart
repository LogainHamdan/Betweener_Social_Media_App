import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/link_controller.dart';
import '../../models/link.dart';
import '../../models/user.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/my-button_widget.dart';

class AddLinkView extends StatefulWidget {
  static const id = "/addLinkView";

  @override
  State<AddLinkView> createState() => _AddLinkViewState();
}

class _AddLinkViewState extends State<AddLinkView> {
  // late TextEditingController titleController;
  // late TextEditingController linkController;
  // final _formKey = GlobalKey<FormState>();
  //
  // @override
  // void initState() {
  //   titleController = TextEditingController();
  //   linkController = TextEditingController();
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   titleController.dispose();
  //   linkController.dispose();
  //   super.dispose();
  // }
  //
  // void addLink() {
  //   if (_formKey.currentState!.validate()) {
  //     final body = {'title': titleController, 'link': linkController};
  //     addNewLink(context, body).then((checkData) {
  //       print(checkData);
  //       if (mounted && checkData) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text('Added successfully'),
  //             backgroundColor: Colors.red,
  //             behavior: SnackBarBehavior.floating,
  //             margin: EdgeInsets.all(12),
  //           ),
  //         );
  //
  //         Navigator.pop(context);
  //       }
  //     }).catchError((error) {
  //       print(error);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(error.toString()),
  //           backgroundColor: Colors.red,
  //           behavior: SnackBarBehavior.floating,
  //           margin: const EdgeInsets.all(12),
  //         ),
  //       );
  //     });
  //   }
  // }

  //هادا انا عدته فوق وعدلت عليه، ف لو في مشكلة رحعي كل اشي زي م كان
  //

  late TextEditingController titleController;

  late TextEditingController linkController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    linkController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    linkController.dispose();
    super.dispose();
  }

  addLink() {
    if (_formKey.currentState!.validate()) {
      final body = {'title': titleController.text, 'link': linkController.text};

      addNewLink(context, body).then((checkData) {
        print(checkData);
        if (mounted && checkData == true) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Added successfully'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(12),
          ));
        }
      }).catchError((err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err.toString()),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(12),
        ));
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 60.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  label: 'Title',
                  controller: titleController,
                  hint: 'snapshot',
                  prefix: Icons.text_fields,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter the title';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomTextFormField(
                  controller: linkController,
                  hint: 'Enter your Link',
                  prefix: Icons.link,
                  label: 'link',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter the email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 24.h,
                ),
                MyButton(
                  text: 'Add',
                  onTap: addLink,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
