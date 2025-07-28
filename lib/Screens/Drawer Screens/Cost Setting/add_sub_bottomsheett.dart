import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Providers/subject_cost_provider.dart';
import 'package:ustaad/Screens/Authentication/auth_widgets.dart';
import 'package:ustaad/Models/subject_cost_model.dart';

class AddCostSubjectSheet extends StatefulWidget {
  const AddCostSubjectSheet({super.key});

  @override
  State<AddCostSubjectSheet> createState() => _AddCostSubjectSheetState();
}

class _AddCostSubjectSheetState extends State<AddCostSubjectSheet> {
  final TextEditingController _subjectController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    super.dispose();
  }

  void _addSubjectToProvider() {
    final subjectName = _subjectController.text.trim();
    if (subjectName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a subject name')),
      );
      return;
    }

    final newSubject = SubjectModel(
      name: subjectName,
      enabled: false,
      cost: '',
    );

    final provider = Provider.of<CostSettingProvider>(context, listen: false);
    provider.addSubject(newSubject);

    Navigator.pop(context); // Close bottom sheet
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // This padding moves content up when keyboard appears
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/radial.png"),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/images/addPlus.png"),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  AppText.appText(
                    "Add Subject",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 10),
                  AppText.appText(
                    "Add relevant subject to your profile",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    textColor: const Color(0xff4D5874),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 1,
              width: ScreenSize(context).width,
              color: const Color(0xffE0E3EB),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: customLableField(
                lable: "Subject",
                controller: _subjectController,
                hintText: "Subject Name",
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 1,
              width: ScreenSize(context).width,
              color: const Color(0xffE0E3EB),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: AppButton.appButton(
                  "Add",
                  context: context,
                  width: 85,
                  height: 52,
                  onTap: _addSubjectToProvider,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
