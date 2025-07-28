import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Models/subject_cost_model.dart';
import 'package:ustaad/Providers/subject_cost_provider.dart';
import 'package:ustaad/Screens/Drawer%20Screens/Cost%20Setting/add_sub_bottomsheett.dart';
import 'package:ustaad/custom%20widgets/app_bar.dart';

class CostSetting extends StatefulWidget {
  const CostSetting({super.key});

  @override
  State<CostSetting> createState() => _CostSettingState();
}

class _CostSettingState extends State<CostSetting> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<CostSettingProvider>(context, listen: false)
            .fetchCostSettings());
  }

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
                Consumer<CostSettingProvider>(
                  builder: (context, provider, _) => _counterTile(
                    "Minimum Subjects",
                    provider.minSubjects,
                    () {
                      if (provider.minSubjects > 1) {
                        provider.updateMinSubjects(provider.minSubjects - 1);
                      }
                    },
                    () {
                      provider.updateMinSubjects(provider.minSubjects + 1);
                    },
                  ),
                ),
                Consumer<CostSettingProvider>(
                  builder: (context, provider, _) => _counterTile(
                    "Max Students Daily",
                    provider.maxStudents,
                    () {
                      if (provider.maxStudents > 1) {
                        provider.updateMaxStudents(provider.maxStudents - 1);
                      }
                    },
                    () {
                      provider.updateMaxStudents(provider.maxStudents + 1);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            AppText.appText("Cost Settings (Monthly)",
                fontWeight: FontWeight.w600, fontSize: 16),
            SizedBox(height: 10),
            Expanded(
              child: Consumer<CostSettingProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.subjects.isEmpty) {
                    return const Center(child: Text("No subjects added yet."));
                  }

                  return ListView.builder(
                    itemCount: provider.subjects.length,
                    itemBuilder: (context, index) {
                      final subject = provider.subjects[index];
                      final controller =
                          TextEditingController(text: subject.cost);

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Row(
                              children: [
                                AppText.appText(subject.name,
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                const Spacer(),
                                Transform.scale(
                                  scale: 0.75,
                                  child: Switch(
                                    activeTrackColor: AppTheme.primaryCOlor,
                                    activeColor: Colors.white,
                                    inactiveTrackColor: const Color(0xffE0E3EB),
                                    inactiveThumbColor: const Color(0xffC8CDDA),
                                    value: subject.enabled,
                                    onChanged: (val) {
                                      provider.updateSubject(
                                        index,
                                        SubjectModel(
                                          name: subject.name,
                                          enabled: val,
                                          cost: subject.cost,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 100,
                                  child: TextField(
                                    controller: controller,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: const InputDecoration(
                                      hintText: "0.00 RS",
                                    ),
                                    onChanged: (val) {
                                      provider.updateSubject(
                                        index,
                                        SubjectModel(
                                          name: subject.name,
                                          enabled: subject.enabled,
                                          cost: val,
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            width: ScreenSize(context).width,
                            color: const Color(0xffE0E3EB),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Align(
                alignment: Alignment.centerLeft,
                child: AppButton.appButton("Add More", onTap: () {
                  showModalBottomSheet(
                    backgroundColor: AppTheme.white,
                    context: context,
                    isScrollControlled: true,
                    isDismissible: false,
                    enableDrag: false,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) => AddCostSubjectSheet(),
                  );
                },
                    context: context,
                    width: 130,
                    textColor: AppTheme.appColor,
                    image: "assets/images/add.png",
                    backgroundColor: Color(0xffEEFBF4))),
            SizedBox(height: 20),
            AppButton.appButton(
              "Save",
              context: context,
              textColor: AppTheme.white,
              backgroundColor: AppTheme.primaryCOlor,
              onTap: () {
                Provider.of<CostSettingProvider>(context, listen: false)
                    .saveCostSettings();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Cost settings saved.")),
                );
              },
            )
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
