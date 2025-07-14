import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Providers/tutor_about_provider.dart';
import 'package:ustaad/Screens/Teacher%20Screens/Profile/about_bottomsheet.dart';

class TutorAboutSection extends StatefulWidget {
  const TutorAboutSection({super.key});

  @override
  State<TutorAboutSection> createState() => _TutorAboutSectionState();
}

class _TutorAboutSectionState extends State<TutorAboutSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AboutProvider>(context, listen: false)
          .fetchAboutData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AboutProvider>(context);
    final data = provider.aboutData;
    final bool hasAbout = data != null && data.about.trim().isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: AppButton.appButton(
            hasAbout ? "Edit About" : "Add About", // ✅ Change label
            image:
                hasAbout ? "assets/images/edit.png" : "assets/images/plus.png",
            context: context,
            onTap: () {
              showModalBottomSheet(
                backgroundColor: AppTheme.white,
                context: context,
                isScrollControlled: true,
                isDismissible: false,
                enableDrag: false,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => AddAboutBottomSheet(
                  isEdit: hasAbout,
                  existingAbout: data?.about ?? '',
                  existingGrade: data?.grade ?? 1,
                ),
              );
            },
            height: 36,
            width: 125,
            textColor: AppTheme.white,
            borderColor: AppTheme.appColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        data == null || data.about.isEmpty
            ? const Text("No about info added yet.")
            : AppText.appText(
                data.about,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textColor: const Color(0xff9095A6),
              ),
        SizedBox(
          height: 20,
        ),
        AppText.appText("Subjects I Can Teach", fontWeight: FontWeight.bold),
        const SizedBox(height: 10),
        data == null || data.subjects.isEmpty
            ? const Text("No subjects added.")
            : Wrap(
                spacing: 8,
                runSpacing: 8,
                children: data.subjects
                    .map((subj) => Chip(
                          label: Text(subj),
                          backgroundColor: AppTheme.white,
                        ))
                    .toList(),
              ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerLeft,
          child:
              Text("Upto Grade", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 8),
        Container(
          height: 45,
          padding: EdgeInsets.symmetric(horizontal: 5),
          width: ScreenSize(context).width,
          decoration: BoxDecoration(
              border: Border.all(color: AppTheme.hintColor),
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: AppText.appText(
              data?.grade != null ? "Grade ${data!.grade}" : "Grade not added",
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
