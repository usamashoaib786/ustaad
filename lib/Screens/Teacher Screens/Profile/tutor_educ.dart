import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Screens/Authentication/auth_widgets.dart';

class TutorEducationScreen extends StatefulWidget {
  const TutorEducationScreen({super.key});

  @override
  State<TutorEducationScreen> createState() => _TutorEducationScreenState();
}

class _TutorEducationScreenState extends State<TutorEducationScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerRight,
            child: AppButton.appButton(
              "Add Education",
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
                  builder: (context) => const AddEducationBottomSheet(),
                );
              },
              height: 36,
              width: 125,
              textColor: AppTheme.white,
              borderColor: AppTheme.appColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            )),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 80,
                      child: AppText.appText("2015 - 2019",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          textColor: Color(0xff2A2A2A)),
                    ),
                    SizedBox(
                      width: ScreenSize(context).width - 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Image.asset(
                                  "assets/images/dot.png",
                                  height: 5,
                                  color: AppTheme.grey,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: ScreenSize(context).width - 160,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText.appText("University of the Punjab",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        textColor: Color(0xff2A2A2A)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    AppText.appText("2015 - 2019",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        textColor: Color(0xff2A2A2A)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    AppText.appText(
                                        "I graduated in July 2019 with a GPA of 3.63. One of the award recipients for the best graduate of the university at the time. In my thesis, I looked into how Natural Language Processing (NLP) ",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        textColor: Color(0xff878787)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            );
          },
        ),
      ],
    );
  }
}

class AddEducationBottomSheet extends StatelessWidget {
  const AddEducationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  "Add Education",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 10),
                AppText.appText("Add relevant education to your profile",
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
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 20,
              right: 20,
            ),
            child: Column(
              children: [
                customLableField(
                    height: 52.0,
                    lable: "Name of Institute *",
                    hintText: "University of the Punjab"),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: customLableField(
                          height: 52.0, lable: "From Year", hintText: "2004"),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: customLableField(
                          height: 52.0, lable: "To Year", hintText: "2006"),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                customLableField(
                    height: 100.0,
                    lable: "Description",
                    hintText: "Leave any notes here",
                    maxLines: 3),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
    );
  }
}
