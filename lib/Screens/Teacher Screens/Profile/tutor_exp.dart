import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Providers/tutor_exp_provider.dart';
import 'package:ustaad/Screens/Authentication/auth_widgets.dart';

class TutorExperience extends StatefulWidget {
  const TutorExperience({super.key});

  @override
  State<TutorExperience> createState() => _TutorExperienceState();
}

class _TutorExperienceState extends State<TutorExperience> {
  @override
  void initState() {
    super.initState();
    Provider.of<ExperienceProvider>(context, listen: false).fetchExperiences();
  }

  @override
  Widget build(BuildContext context) {
    final expProvider = Provider.of<ExperienceProvider>(context);
    final experiences = expProvider.experiences;

    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: AppButton.appButton(
            "Add Experience",
            image: "assets/images/plus.png",
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
                builder: (context) => const AddExperienceBottomSheet(),
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
        if (experiences.isEmpty)
          const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text("No experience added yet."))
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: experiences.length,
            itemBuilder: (context, index) {
              final exp = experiences[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppTheme.appColor,
                            image: const DecorationImage(
                              image: AssetImage("assets/images/joblogo.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.appText(exp.company,
                                  fontSize: 16, fontWeight: FontWeight.w500),
                              AppText.appText(
                                '${DateTime.parse(exp.startDate).year} — ${DateTime.parse(exp.endDate).year}',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                textColor: const Color(0xff504E4E),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _buildBulletPoint(exp.description),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 4.0, left: 15),
          child: Icon(Icons.circle, size: 8, color: Color(0xffC4C4C4)),
        ),
        const SizedBox(width: 29),
        Expanded(
          child: AppText.appText(
            text,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            textColor: const Color(0xff504E4E),
          ),
        ),
      ],
    );
  }
}

class AddExperienceBottomSheet extends StatefulWidget {
  const AddExperienceBottomSheet({super.key});

  @override
  State<AddExperienceBottomSheet> createState() =>
      _AddExperienceBottomSheetState();
}

class _AddExperienceBottomSheetState extends State<AddExperienceBottomSheet> {
  final TextEditingController _company = TextEditingController();

  final TextEditingController _startDate = TextEditingController();

  final TextEditingController _endDate = TextEditingController();

  final TextEditingController _description = TextEditingController();
  DateTime? _startDateRaw;
  DateTime? _endDateRaw;
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
                  "Add Experience",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 10),
                AppText.appText("Add relevant experience to your profile",
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
                    lable: "Name of Company *",
                    controller: _company,
                    hintText: "University of the Punjab"),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1980),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              _startDateRaw = pickedDate; // raw date
                              _startDate.text = DateFormat('dd/MM/yyyy')
                                  .format(pickedDate); // formatted display
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: customLableField(
                            height: 52.0,
                            lable: "From Date",
                            controller: _startDate,
                            hintText: "MM/YYYY",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1980),
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate != null) {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              _endDateRaw = pickedDate; // raw date
                              _endDate.text = DateFormat('dd/MM/yyyy')
                                  .format(pickedDate); // formatted display
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: customLableField(
                            height: 52.0,
                            lable: "To Date",
                            controller: _endDate,
                            hintText: "MM/YYYY",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                customLableField(
                    height: 100.0,
                    lable: "Description",
                    controller: _description,
                    hintText: "Leave any notes here",
                    maxLines: 3),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      final provider = Provider.of<ExperienceProvider>(context,
                          listen: false);
                      final experience = Experience(
                        company: _company.text.trim(),
                        startDate: _startDateRaw?.toIso8601String() ?? '',
                        endDate: _endDateRaw?.toIso8601String() ?? '',
                        description: _description.text.trim(),
                      );
                      bool success = await provider.addExperience(experience, context);
                      if (success) Navigator.pop(context);
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
