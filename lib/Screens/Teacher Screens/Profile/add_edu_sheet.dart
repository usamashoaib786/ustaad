import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Providers/tutor_education_provider.dart';
import 'package:ustaad/Screens/Authentication/auth_widgets.dart';

class AddEducationBottomSheet extends StatefulWidget {
  const AddEducationBottomSheet({super.key});

  @override
  State<AddEducationBottomSheet> createState() =>
      _AddEducationBottomSheetState();
}

class _AddEducationBottomSheetState extends State<AddEducationBottomSheet> {
  final TextEditingController _institute = TextEditingController();

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
                    controller: _institute,
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
                      final provider = Provider.of<EducationProvider>(context,
                          listen: false);
                      final education = Education(
                        institute: _institute.text.trim(),
                        startDate: _startDateRaw?.toIso8601String() ?? '',
                        endDate: _endDateRaw?.toIso8601String() ?? '',
                        description: _description.text.trim(),
                      );
                      bool success =
                          await provider.addEducation(education, context);
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
