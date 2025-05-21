import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';

class TutorAboutSection extends StatefulWidget {
  const TutorAboutSection({super.key});

  @override
  State<TutorAboutSection> createState() => _TutorAboutSectionState();
}

class _TutorAboutSectionState extends State<TutorAboutSection> {
  final List<String> subjects = ['Physics', 'Chemistry'];
  final TextEditingController _subjectController = TextEditingController();
  int grade = 12;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText.appText(
            "Excellent two-storey villa with a terrace, private pool and parking spaces is located only 5 minutes from the Indian Ocean. Excellent two-storey villa with parking.Excellent two-storey villa with a terrace, private pool and parking spaces is located only 5 minutes from the Indian Ocean.",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            textColor: Color(0xff9095A6)),
        SizedBox(
          height: 20,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text("Subjects I Can teach",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _subjectController,
          decoration: InputDecoration(
            hintText: 'Add Subjects...',
            suffixIcon: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                if (_subjectController.text.isNotEmpty) {
                  setState(() {
                    subjects.add(_subjectController.text);
                    _subjectController.clear();
                  });
                }
              },
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: subjects
              .map((subj) => Chip(
                    label: Text(subj),
                    backgroundColor: AppTheme.white,
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () => setState(() => subjects.remove(subj)),
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
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (grade > 1) grade--;
                    });
                  },
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
                  child: Text("$grade", style: const TextStyle(fontSize: 18))),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (grade < 12) grade++;
                    });
                  },
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
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
