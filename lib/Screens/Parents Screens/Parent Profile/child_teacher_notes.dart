import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Models/child_detail_model.dart';

class ChildTeacherNotes extends StatefulWidget {
  const ChildTeacherNotes({super.key});

  @override
  State<ChildTeacherNotes> createState() => _ChildTeacherNotesState();
}

class _ChildTeacherNotesState extends State<ChildTeacherNotes> {
  List<Child> childList = [];
  Child? selectedChild;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: DropdownButtonFormField<Child>(
            value: selectedChild,
            icon: const Icon(Icons.keyboard_arrow_down),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
            items: childList.map((child) {
              return DropdownMenuItem<Child>(
                value: child,
                child: Text(
                  child.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
              );
            }).toList(),
            onChanged: (Child? value) {
              if (value != null) {
                setState(() {
                  selectedChild = value;
                });
              }
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        for (int i = 0; i < 5; i++)
          Card(
            margin: const EdgeInsets.only(bottom: 15.0),
            child: Container(
              width: ScreenSize(context).width,
              decoration: BoxDecoration(
                  color: Color(0xffC2FEB3),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/notes.png",
                          height: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        AppText.appText("Note by Mr Ali  (24-10-2035)",
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            textColor: Color(0xff212121))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppText.appText("Description Goes Here",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        textColor: Color(0xff616161))
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
