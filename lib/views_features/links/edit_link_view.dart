import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/link_controller.dart';
import '../../models/link.dart';
import '../../models/user.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/my-button_widget.dart';

class EditLinkView extends StatefulWidget {
  static const id = "/editLinkView";
  late String textTitle;
  late String textLink;
  late String linkId;

  EditLinkView(
      {super.key,
      required this.textTitle,
      required this.textLink,
      required this.linkId});

  @override
  State<EditLinkView> createState() => _EditLinkViewState();
}

class _EditLinkViewState extends State<EditLinkView> {
  late TextEditingController titleController;

  late TextEditingController linkController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.textTitle);
    linkController = TextEditingController(text: widget.textLink);
  }

  @override
  void dispose() {
    titleController.dispose();
    // linkController.dispose();
    super.dispose();
  }

  editLink() {
    if (_formKey.currentState!.validate()) {
      final body = {'title': titleController.text, 'link': widget.textLink};

      editNewLink(context, body, widget.linkId).then((updatedLink) {
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Updated successfully'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(12),
          ));
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.toString()),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(12),
        ));
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
                  // hint: 'snapshot',
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
                  // hint: 'Enter your Link',
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
                  text: 'Update',
                  onTap: editLink,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
