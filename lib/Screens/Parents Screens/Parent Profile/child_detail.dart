import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Models/child_detail_model.dart';
import 'package:ustaad/Providers/parent_profile_provider.dart';
import 'package:ustaad/Screens/Authentication/auth_widgets.dart';
import 'package:ustaad/Screens/Parents%20Screens/Parent%20Profile/add_child_sheet.dart';

class ChildDetails extends StatefulWidget {
  final String userId;
  const ChildDetails({super.key, required this.userId});

  @override
  State<ChildDetails> createState() => _ChildDetailsState();
}

class _ChildDetailsState extends State<ChildDetails> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();

  @override
  void initState() {
    super.initState();
 
  }

  void populateFields(Child child) {
    _ageController.text = child.age;
    _schoolController.text = child.school;
    _genderController.text = child.gender;
    _gradeController.text = child.grade;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ParentProfileProvider>(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final child = provider.selectedChild;
    if (child != null) {
      populateFields(child);
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffD4D8E2)),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<Child>(
                      value: provider.selectedChild,
                      isExpanded: true,
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (Child? value) {
                        if (value != null) {
                          provider.selectChild(value);
                        }
                      },
                      items: provider.children.map((child) {
                        return DropdownMenuItem<Child>(
                          value: child,
                          child: Text(
                            child.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        height: 44,
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(Icons.keyboard_arrow_down),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 40,),
              Align(
                  alignment: Alignment.centerRight,
                  child: AppButton.appButton(
                    "Add Child",
                    image: "assets/images/plus.png",
                    context: context,
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: AppTheme.white,
                        context: context,
                        isScrollControlled: true,
                        isDismissible: false, // 👈 disable tap outside to close
                        enableDrag: false, // 👈 disable drag down to close
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => const AddChildBottomSheet(),
                      );
                    },
                    height: 36,
                    width: 100,
                    textColor: AppTheme.white,
                    borderColor: AppTheme.appColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
          const SizedBox(height: 20),
          customLableField(lable: "Age", controller: _ageController),
          const SizedBox(height: 20),
          customLableField(lable: "School", controller: _schoolController),
          const SizedBox(height: 20),
          customLableField(lable: "Class", controller: _gradeController),
          const SizedBox(height: 20),
          customLableField(lable: "Gender", controller: _genderController),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
