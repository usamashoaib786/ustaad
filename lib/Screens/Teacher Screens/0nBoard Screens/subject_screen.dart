import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_field.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Screens/Authentication/SignUP/widgets.dart';

class SubjectSelectionScreen extends StatefulWidget {
  const SubjectSelectionScreen({super.key});

  @override
  State<SubjectSelectionScreen> createState() => _SubjectSelectionScreenState();
}

class _SubjectSelectionScreenState extends State<SubjectSelectionScreen> {
  List<String> allSubjects = [
    'Biology',
    'Chemistry',
    'English',
    'Urdu',
    'Arabic',
    'Accounting',
    'Arabic',
    'Mathematics',
    'Accounting',
    'Mathematics',
  ];

  List<String> filteredSubjects = [];
  List<String> selectedSubjects = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredSubjects = allSubjects;
  }

  void _filterSubjects(String query) {
    setState(() {
      filteredSubjects = allSubjects
          .where(
              (subject) => subject.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _toggleSelection(String subject) {
    setState(() {
      if (selectedSubjects.contains(subject)) {
        selectedSubjects.remove(subject);
      } else {
        selectedSubjects.add(subject);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: 'Let Us ',
              style: TextStyle(
                  fontSize: 44,
                  color: AppTheme.black,
                  fontWeight: FontWeight.w400),
              children: [
                TextSpan(
                  text: 'Know You Before',
                  style: TextStyle(
                      color: AppTheme.appColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 44),
                ),
                TextSpan(text: ' You Start'),
              ],
            ),
          ),
          SizedBox(height: 20),
          AppText.appText(
            'What Subjects Do You Intend to teach?',
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomAppTextField(
                width: ScreenSize(context).width * 0.65,
                texthint: "Search/Add Subject",
                controller: searchController,
                onChanged: _filterSubjects,
                prefixIcon: Icon(Icons.search),
                suffix: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          _filterSubjects('');
                        },
                      )
                    : null,
              ),
              if (selectedSubjects.isNotEmpty)
                Container(
                  height: 30,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.appColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: AppText.appText("${selectedSubjects.length} Selected",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      textColor: AppTheme.appColor),
                ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSubjects.length,
              itemBuilder: (context, index) {
                String subject = filteredSubjects[index];
                bool isSelected = selectedSubjects.contains(subject);
                return Column(
                  children: [
                    if (index == 0)
                      SizedBox(
                        height: 10,
                      ),
                    GestureDetector(
                      onTap: () => _toggleSelection(subject),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 6),
                        width: ScreenSize(context).width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.teal.shade50
                              : Colors.transparent,
                          border: Border.all(
                            color:
                                isSelected ? Colors.teal : AppTheme.borderCOlor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: AppText.appText(
                          subject,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Proceed Button

          AppButton.appButton("Proceed",
              context: context,
              onTap: selectedSubjects.isEmpty
                  ? null
                  : () {
                      // Handle next step
                    },
              height: 52,
              backgroundColor: AppTheme.primaryCOlor)
        ],
      ),
    );
  }
}
