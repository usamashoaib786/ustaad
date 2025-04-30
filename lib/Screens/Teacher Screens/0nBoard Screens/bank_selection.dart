import 'package:flutter/material.dart';

class BankSelectionScreen extends StatefulWidget {
  const BankSelectionScreen({super.key});

  @override
  State<BankSelectionScreen> createState() => _BankSelectionScreenState();
}

class _BankSelectionScreenState extends State<BankSelectionScreen> {
  String? selectedBank = "HBL Bank";
  final List<String> banks = [
    "HBL Bank",
    "UBL Bank",
    "MCB",
    "Alfalah",
    "Meezan"
  ];
  final TextEditingController accountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  children: [
                    TextSpan(text: "We’ll "),
                    TextSpan(
                        text: "Take Care ",
                        style: TextStyle(color: Colors.teal)),
                    TextSpan(text: "of Your Valuable "),
                    TextSpan(
                        text: "Earnings", style: TextStyle(color: Colors.teal)),
                  ],
                ),
              ),
              SizedBox(height: 10),

              // Subtitle
              Text(
                "Add Your Payout Method",
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
              ),
              SizedBox(height: 30),

              // Select Your Bank
              Text(
                "Select Your Bank",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
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
                            // Optional bank icon (hardcoded flag for HBL)
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

              // Account Number
              Text(
                "Account Number",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              SizedBox(height: 8),
              TextField(
                controller: accountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "1234 1234 1234 1234",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              Spacer(),

              // Proceed Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1F87A6),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // if (_tabController.index < 2) {
                    //   setState(() {
                    //     _tabController.animateTo(_tabController.index + 1);
                    //   });
                    // }
                  },
                  child: Text(
                    "Proceed",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
