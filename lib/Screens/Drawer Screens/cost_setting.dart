import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_field.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/custom%20widgets/app_bar.dart';

class CostSetting extends StatefulWidget {
  const CostSetting({super.key});

  @override
  State<CostSetting> createState() => _CostSettingState();
}

class _CostSettingState extends State<CostSetting> {
  int minSubjects = 3;
  int maxStudents = 3;

  final List<Map<String, dynamic>> subjects = [
    {'name': 'Biology', 'enabled': true, 'cost': ''},
    {'name': 'Physics', 'enabled': true, 'cost': ''},
    {'name': 'Chemistry', 'enabled': true, 'cost': ''},
    {'name': 'English', 'enabled': true, 'cost': ''},
    {'name': 'Urdu', 'enabled': true, 'cost': ''},
    {'name': 'Pak Studies', 'enabled': false, 'cost': ''},
    {'name': 'Islamiat', 'enabled': false, 'cost': ''},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _counterTile("Minimum Subjects", minSubjects, () {
                  setState(() {
                    if (minSubjects > 1) minSubjects--;
                  });
                }, () {
                  setState(() {
                    minSubjects++;
                  });
                }),
                _counterTile("Max Students Daily", maxStudents, () {
                  setState(() {
                    if (maxStudents > 1) maxStudents--;
                  });
                }, () {
                  setState(() {
                    maxStudents++;
                  });
                }),
              ],
            ),
            SizedBox(height: 20),
            AppText.appText("Cost Settings (Monthly)",
                fontWeight: FontWeight.w600, fontSize: 16),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Row(
                          children: [
                            AppText.appText(subjects[index]['name'],
                                fontSize: 14, fontWeight: FontWeight.w500),
                            Spacer(),
                            Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                activeTrackColor: AppTheme
                                    .primaryCOlor, // Track color when ON
                                activeColor:
                                    Colors.white, // Thumb color when ON
                                inactiveTrackColor:
                                    Color(0xffE0E3EB), // Track color when OFF
                                inactiveThumbColor: Color(0xffC8CDDA),
                                value: subjects[index]['enabled'],
                                onChanged: (val) {
                                  setState(() {
                                    subjects[index]['enabled'] = val;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CustomAppTextField(
                              texthint: "0.00 RS",
                              controller: null,
                              width: 100,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: ScreenSize(context).width,
                        color: Color(0xffE0E3EB),
                      )
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Align(
                alignment: Alignment.centerLeft,
                child: AppButton.appButton("Add More",
                    context: context,
                    width: 130,
                    textColor: AppTheme.appColor,
                    image: "assets/images/add.png",
                    backgroundColor: Color(0xffEEFBF4))),
            SizedBox(height: 20),
            AppButton.appButton("Save",
                context: context,
                textColor: AppTheme.white,
                backgroundColor: AppTheme.primaryCOlor)
          ],
        ),
      ),
    );
  }

  Widget _counterTile(String label, int value, VoidCallback onDecrement,
      VoidCallback onIncrement) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.appText(label, fontSize: 14, fontWeight: FontWeight.w500),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: 5),
              width: ScreenSize(context).width * 0.4,
              decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.hintColor),
                  borderRadius: BorderRadius.circular(8)),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: onDecrement,
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppTheme.primaryCOlor),
                        child: Icon(Icons.remove, color: AppTheme.white),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child:
                          Text("$value", style: const TextStyle(fontSize: 18))),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: onIncrement,
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppTheme.primaryCOlor),
                        child: Icon(
                          Icons.add,
                          color: AppTheme.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
