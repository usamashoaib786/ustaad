import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Helpers/toaster.dart';
import 'package:ustaad/Providers/tutor_about_provider.dart';
import 'package:ustaad/Screens/Authentication/auth_widgets.dart';

class AddAboutBottomSheet extends StatefulWidget {
  final bool isEdit;
  final String existingAbout;
  final int existingGrade;

  const AddAboutBottomSheet({
    super.key,
    this.isEdit = false,
    this.existingAbout = '',
    this.existingGrade = 0,
  });

  @override
  State<AddAboutBottomSheet> createState() => _AddAboutBottomSheetState();
}

class _AddAboutBottomSheetState extends State<AddAboutBottomSheet> {
  late TextEditingController _aboutController;
  late int _grade;

  @override
  void initState() {
    super.initState();
    _aboutController = TextEditingController(text: widget.existingAbout);
    _grade = widget.existingGrade > 0 ? widget.existingGrade : 1;
  }

  @override
  void dispose() {
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/radial.png"))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/images/addPlus.png"),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context); // 👈 only this closes the sheet
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                AppText.appText(
                  widget.isEdit ? "Edit About" : "Add About",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 10),
                AppText.appText(widget.isEdit ?"Edit your experience":"Add relevant experience to your profile",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    textColor: Color(0xff4D5874)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            width: ScreenSize(context).width,
            color: AppTheme.hintColor,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                customLableField(
                  lable: "About",
                  controller: _aboutController,
                  hintText: "Enter your about section...",
                  maxLines: 3,
                  height: 100.0,
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Up to Grade",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.hintColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (_grade > 1) _grade--;
                            });
                          },
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppTheme.primaryCOlor,
                            ),
                            child:
                                const Icon(Icons.remove, color: Colors.white),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text("$_grade",
                            style: const TextStyle(fontSize: 18)),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (_grade < 12) _grade++;
                            });
                          },
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppTheme.primaryCOlor,
                            ),
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      final aboutText = _aboutController.text.trim();

                      if (aboutText.isEmpty) {
                        ToastHelper.displayErrorMotionToast(
                          context: context,
                          msg: "Please enter about text",
                        );
                        return;
                      }

                      if (_grade <= 0) {
                        ToastHelper.displayErrorMotionToast(
                          context: context,
                          msg: "Please select a valid grade",
                        );
                        return;
                      }

                      final provider =
                          Provider.of<AboutProvider>(context, listen: false);

                      bool success = false;

                      if (widget.isEdit) {
                        success = await provider.updateAboutData(
                          aboutText,
                          _grade,
                          context,
                        );
                      } else {
                        success = await provider.addAboutData(
                          aboutText,
                          _grade,
                          context,
                        );
                      }

                      if (success) Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryCOlor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      widget.isEdit ? "Update" : "Add",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
