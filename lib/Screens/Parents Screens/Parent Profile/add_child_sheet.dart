import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Screens/Authentication/auth_widgets.dart';

class AddChildBottomSheet extends StatefulWidget {
  const AddChildBottomSheet({super.key});

  @override
  State<AddChildBottomSheet> createState() => _AddChildBottomSheetState();
}

class _AddChildBottomSheetState extends State<AddChildBottomSheet> {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController grade = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController schoolName = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? selectedGender;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context); // 👈 only this closes the sheet
                  },
                  icon: Icon(Icons.close),
                ),
              ),
              AppText.appText(
                "Add Child",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 1,
          width: ScreenSize(context).width,
          color: AppTheme.hintColor,
        ),
     Expanded(
       child: SingleChildScrollView(
         child: Column(
          children: [
               buildChildForm(),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            )
         
          ],
         ),
       ),
     ) ],
    );
  }

  Widget buildChildForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage:
                    const AssetImage("assets/images/user.png") as ImageProvider,
              ),
              Column(
                children: [
                  AppButton.appButton("Upload New",
                      context: context,
                      width: 200,
                      onTap: () => _pickImage(),
                      backgroundColor: const Color(0xffF1FCF9),
                      border: false,
                      textColor: AppTheme.appColor),
                  SizedBox(
                    height: 10,
                  ),
                  AppButton.appButton("Delete Image",
                      context: context,
                      width: 200,
                      onTap: () => _deleteImage(),
                      backgroundColor: const Color(0xffFEECEC),
                      border: false,
                      textColor: Colors.red),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          customLableField(lable: "Child Full Name", controller: fullName),
          const SizedBox(height: 20),
          AppText.appText("Gender",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              textColor: AppTheme.lableText),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _genderTile(
                "Male",
              ),
              _genderTile("Female"),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customLableField(
                  lable: "Grade",
                  width: ScreenSize(context).width * 0.4,
                  controller: grade),
              customLableField(
                  lable: "Age",
                  width: ScreenSize(context).width * 0.4,
                  controller: age),
            ],
          ),
          const SizedBox(height: 20),
          customLableField(lable: "School Name", controller: schoolName),
        ],
      ),
    );
  }

  Widget _genderTile(
    String gender,
  ) {
    return GestureDetector(
      onTap: () => setState(() => selectedGender = gender),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 44,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedGender == gender
                ? AppTheme.appColor
                : const Color(0xffD4D8E2),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: gender,
              groupValue: selectedGender,
              activeColor: AppTheme.appColor,
              onChanged: (value) => setState(() => selectedGender = value),
            ),
            Text(gender),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {}
  }

  void _deleteImage() {}
}
