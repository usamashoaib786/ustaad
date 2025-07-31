import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Providers/tutor_education_provider.dart';
import 'package:ustaad/Screens/Teacher%20Screens/Profile/add_edu_sheet.dart';

class TutorEducationScreen extends StatefulWidget {
  final bool isParentSide;
  final Map<String, dynamic>? data;
  const TutorEducationScreen(
      {super.key, required this.isParentSide, this.data});

  @override
  State<TutorEducationScreen> createState() => _TutorEducationScreenState();
}

class _TutorEducationScreenState extends State<TutorEducationScreen> {
  @override
  void initState() {
    super.initState();

    if (widget.isParentSide == false) {
      Provider.of<EducationProvider>(context, listen: false)
          .fetchEducation(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final eduProvider = Provider.of<EducationProvider>(context);
    final educations = eduProvider.education;
    return Column(
      children: [
        if (widget.isParentSide == false)
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
        parentCheckLogic(educations: educations),
      ],
    );
  }

  Widget parentCheckLogic({educations}) {
    if (widget.isParentSide == true) {
      final parentEducations = widget.data?["TutorEducations"];
      if (parentEducations == null || parentEducations.isEmpty) {
        return const Padding(
          padding: EdgeInsets.only(top: 50),
          child: Text("No Education added yet."),
        );
      }
      return customEduListView();
    } else {
      if (educations == null || educations.isEmpty) {
        return const Padding(
          padding: EdgeInsets.only(top: 50),
          child: Text("No Education added yet."),
        );
      } else {
        return customEduListView(educations: educations);
      }
    }
  }

  Widget customEduListView({educations}) {
    final parentEducations = widget.data?["TutorEducations"];
    final isParent = widget.isParentSide == true;

    final itemCount =
        isParent ? (parentEducations?.length ?? 0) : (educations?.length ?? 0);

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final edu = isParent ? null : educations[index];
        final eduData = isParent ? parentEducations[index] : null;
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: AppText.appText(
                      widget.isParentSide == true
                          ? "${DateTime.parse(eduData["startDate"]).year} — ${DateTime.parse(eduData["endDate"]).year}"
                          : "${DateTime.parse(edu.startDate).year} — ${DateTime.parse(edu.endDate).year}",
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
                                AppText.appText(
                                    widget.isParentSide == true
                                        ? "${eduData["institute"]}"
                                        : edu.institute,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    textColor: Color(0xff2A2A2A)),
                                SizedBox(
                                  height: 5,
                                ),
                                AppText.appText(
                                    widget.isParentSide == true
                                        ? "${DateTime.parse(eduData["startDate"]).year} — ${DateTime.parse(eduData["endDate"]).year}"
                                        : "${DateTime.parse(edu.startDate).year} — ${DateTime.parse(edu.endDate).year}",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    textColor: Color(0xff2A2A2A)),
                                SizedBox(
                                  height: 5,
                                ),
                                AppText.appText(
                                    widget.isParentSide == true
                                        ? "${eduData["description"]}"
                                        : edu.description,
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
    );
  }
}
