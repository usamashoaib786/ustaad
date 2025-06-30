import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_field.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';

class ParentAddPayment extends StatefulWidget {
  final Function()? onTap;
  const ParentAddPayment({super.key, this.onTap});

  @override
  State<ParentAddPayment> createState() => _ParentAddPaymentState();
}

class _ParentAddPaymentState extends State<ParentAddPayment> {
  String? selectedGender;
  String selectedMethod = 'Card';
  bool saveCard = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'Add ',
                style: TextStyle(
                    fontSize: 44,
                    color: AppTheme.appColor,
                    fontWeight: FontWeight.w600),
                children: [
                  TextSpan(
                    text: 'Your Own ',
                    style: TextStyle(
                        color: AppTheme.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 44),
                  ),
                  TextSpan(
                    text: "Payment Method",
                    style: TextStyle(
                        color: AppTheme.appColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 44),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            AppText.appText(
              'Add a new payment method to your account.',
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 20),
            // Payment method toggle
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedMethod = 'Card'),
                    child: Container(
                      height: 64,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedMethod == 'Card'
                              ? Colors.green
                              : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: selectedMethod == 'Card'
                            ? Colors.green.withOpacity(0.05)
                            : Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "assets/images/card.png",
                              height: 20,
                              color: selectedMethod == 'Card'
                                  ? Colors.green
                                  : Color(0xffA6ADBF),
                            ),
                            Text(
                              'Card',
                              style: TextStyle(
                                color: selectedMethod == 'Card'
                                    ? Colors.green
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedMethod = 'Apple'),
                    child: Container(
                      height: 64,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedMethod == 'Apple'
                              ? Colors.green
                              : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: selectedMethod == 'Apple'
                            ? Colors.green.withOpacity(0.05)
                            : Colors.transparent,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  "assets/images/apple.png",
                                  height: 20,
                                  color: selectedMethod == 'Apple'
                                      ? Colors.green
                                      : Color(0xffA6ADBF),
                                ),
                                Text(
                                  'Apple',
                                  style: TextStyle(
                                    color: selectedMethod == 'Apple'
                                        ? Colors.green
                                        : Colors.black,
                                  ),
                                ),
                              ])),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Card number
            AppText.appText("Name on card",
                fontSize: 14, fontWeight: FontWeight.w500),
            SizedBox(height: 10),
            CustomAppTextField(
              texthint: "Ahmed Ali",
              controller: null,
              prefixIcon: Icon(Icons.person_outline),
            ),

            SizedBox(height: 20),

            // Card number
            AppText.appText("Card Numbers",
                fontSize: 14, fontWeight: FontWeight.w500),
            SizedBox(height: 10),
            CustomAppTextField(
              texthint: "1234 1234 1234",
              controller: null,
              prefixIcon: Icon(Icons.credit_card),
            ),
            SizedBox(height: 20),

            // Expiry & CVC
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Expiry',
                      prefixIcon: Icon(Icons.date_range_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'CVC',
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),

            // Save card checkbox
            Row(
              children: [
                Checkbox(
                  value: saveCard,
                  onChanged: (value) {
                    setState(() => saveCard = value!);
                  },
                ),
                Text("Save card for future payment"),
              ],
            ),
            SizedBox(height: 20),

            AppButton.appButton("Proceed",
                context: context,
                onTap: widget.onTap,
                textColor: AppTheme.white,
                border: false,
                height: 44,
                backgroundColor: AppTheme.primaryCOlor)
          ],
        ),
      ),
    );
  }
}
