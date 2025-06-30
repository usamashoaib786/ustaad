import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Screens/Authentication/auth_widgets.dart';
import 'package:ustaad/Screens/Teacher%20Screens/0nBoard%20Screens/data_model.dart';

class BankSelectionScreen extends StatefulWidget {
  final VoidCallback onTap;
  final TutorOnboardData onboardData;
  const BankSelectionScreen(
      {super.key, required this.onTap, required this.onboardData});

  @override
  State<BankSelectionScreen> createState() => _BankSelectionScreenState();
}

class _BankSelectionScreenState extends State<BankSelectionScreen> {
  final TextEditingController accountController = TextEditingController();

  String? selectedBank = "HBL Bank";
  final List<String> banks = [
    "HBL Bank",
    "UBL Bank",
    "MCB",
    "Alfalah",
    "Meezan"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: [
                      TextSpan(
                          text: "We'll ",
                          style: TextStyle(
                              fontSize: 44, fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: "Take Care ",
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 44,
                              fontWeight: FontWeight.w600)),
                      TextSpan(
                        text: "of Your Valuable ",
                        style: TextStyle(
                            fontSize: 44, fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                          text: "Earnings",
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 44,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                AppText.appText(
                  "Add Your Payout Method",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 30),
                AppText.appText("Select Your Bank",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    textColor: AppTheme.black),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.borderCOlor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedBank,
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: banks.map((bank) {
                        return DropdownMenuItem<String>(
                          value: bank,
                          child: Row(
                            children: [
                              if (bank == "HBL Bank")
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Image.network(
                                    "https://flagcdn.com/w40/sa.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              Text(bank),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => selectedBank = value);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                AppText.appText("Card Number",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    textColor: AppTheme.lableText),
                SizedBox(
                  height: 10,
                ),
                CardNumberField(
                  controller: accountController,
                ),
                SizedBox(
                  height: 40,
                ),
                AppButton.appButton("Proceed", context: context, onTap: () {
                  widget.onboardData.selectedBank = selectedBank;
                  widget.onboardData.accountNumber =
                      accountController.text.trim();
                  widget.onTap();
                },
                    textColor: AppTheme.white,
                    border: false,
                    height: 52,
                    backgroundColor: AppTheme.primaryCOlor)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
