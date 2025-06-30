import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_field.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';

class LoactionScreen extends StatefulWidget {
  const LoactionScreen({Key? key}) : super(key: key);

  @override
  State<LoactionScreen> createState() => _LoactionScreenState();
}

class _LoactionScreenState extends State<LoactionScreen> {
  final TextEditingController searchController = TextEditingController();
  List<String> allLocations = [
    "DHA Phase 1",
    "DHA Phase 2",
    "DHA Phase 3",
    "DHA Phase 4",
    "DHA Phase 5",
    "DHA Phase 6",
  ];

  List<String> filteredLocations = [];
  List<String> selectedLocations = [];

  @override
  void initState() {
    super.initState();
    filteredLocations = List.from(allLocations);
  }

  void _filterLocations(String query) {
    setState(() {
      filteredLocations = allLocations
          .where((loc) => loc.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _toggleSelection(String subject) {
    setState(() {
      if (selectedLocations.contains(subject)) {
        selectedLocations.remove(subject);
      } else {
        selectedLocations.add(subject);
      }
    });
  }

  void _removeLocation(int index) {
    setState(() {
      String toRemove = filteredLocations[index];
      allLocations.remove(toRemove);
      _filterLocations(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => Navigator.pop(context),
            child: Image.asset("assets/images/arrowBack.png")
          ),
        ),
        title: AppText.appText(
          "Add Location",
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomAppTextField(
                  width: ScreenSize(context).width * 0.7,
                  texthint: "Search/Add Subject",
                  controller: searchController,
                  onChanged: _filterLocations,
                  prefixIcon: Icon(Icons.search),
                  suffix: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            _filterLocations('');
                          },
                        )
                      : null,
                ),
                if (selectedLocations.isNotEmpty)
                  Container(
                    height: 30,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.appColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AppText.appText(
                        "${selectedLocations.length} Selected",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        textColor: AppTheme.appColor),
                  ),
              ],
            ),
            SizedBox(height: 10),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredLocations.length,
                itemBuilder: (context, index) {
                  String location = filteredLocations[index];
                  // bool isSelected = selectedSubjects.contains(subject);
                  return InkWell(
                    onTap: () {
                      _toggleSelection(location);
                    },
                    child: Container(
                        height: 100,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color.fromARGB(66, 107, 105, 105)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                color: AppTheme.grey,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText.appText(
                                    location,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  AppText.appText(
                                    "3.5 miles away",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.grey,
                                  ),
                                  GestureDetector(
                                    onTap: () => _removeLocation(index),
                                    child: AppText.appText(
                                      "Remove",
                                      underLine: true,
                                      decorationColor: Colors.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      textColor: Colors.red,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
