import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Screens/Authentication/auth_widgets.dart';
import 'package:ustaad/custom%20widgets/app_bar.dart';

class TutorEarningScreen extends StatefulWidget {
  const TutorEarningScreen({super.key});

  @override
  State<TutorEarningScreen> createState() => _TutorEarningScreenState();
}

class _TutorEarningScreenState extends State<TutorEarningScreen> {
  bool showUpcoming = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(backArrow: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 40,
                width: 265,
                decoration: BoxDecoration(
                    color: const Color(0xffECEEF3),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTab("Current Balance", true),
                    _buildTab("Transferred", false),
                  ],
                ),
              ),
            ),
            showUpcoming
                ? _buildBalanceSection(context)
                : Expanded(child: _buildTransferredList(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title, bool isLeft) {
    final isSelected = showUpcoming == isLeft;
    return InkWell(
      onTap: () {
        setState(() {
          showUpcoming = isLeft;
        });
      },
      child: Container(
        height: 35,
        width: 130,
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryCOlor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: AppText.appText(
            title,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            textColor: isSelected ? AppTheme.white : AppTheme.black,
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        AppText.appText("Your Balance",
            fontSize: 16, fontWeight: FontWeight.w400),
        const SizedBox(height: 8),
        AppText.appText("Rs. 12,312.00",
            fontSize: 44, fontWeight: FontWeight.w600),
        const SizedBox(height: 8),
        AppText.appText("You can Withdraw",
            fontSize: 16,
            fontWeight: FontWeight.w400,
            textColor: const Color(0xff8A8A8A)),
        const SizedBox(height: 30),
        AppButton.appButton("Withdraw", context: context, onTap: () {
          showModalBottomSheet(
            backgroundColor: AppTheme.white,
            context: context,
            isScrollControlled: true,
            isDismissible: false,
            enableDrag: false,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => const BankSheet(),
          );
        },
            backgroundColor: AppTheme.primaryCOlor,
            border: false,
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ],
    );
  }

  Widget _buildTransferredList(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            height: 70,
            width: ScreenSize(context).width,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffE7E7E7)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.appText("Mr. Ali Fee **May25",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          textColor: const Color(0xff2E3A59)),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          AppText.appText("****",
                              fontSize: 16, fontWeight: FontWeight.w400),
                          AppText.appText("6098",
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ],
                      ),
                    ],
                  ),
                  AppText.appText("Rs. 15,000",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      textColor: AppTheme.appColor),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ======================= BANK SHEET ============================

class BankSheet extends StatefulWidget {
  const BankSheet({super.key});

  @override
  State<BankSheet> createState() => _BankSheetState();
}

class _BankSheetState extends State<BankSheet> {
  int? _selectedIndex;

  final List<Account> accounts = [
    Account(
        name: 'HBL *4567',
        icon: Icons.account_balance,
        color: Colors.blue),
    Account(
        name: 'Meezan *6678',
        icon: Icons.account_balance,
        color: Colors.green),
    Account(
        name: 'Jazz Cash *7591',
        icon: Icons.phone_android,
        color: Colors.purple),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  AppText.appText("Withdraw Your Amount",
                      fontSize: 18, fontWeight: FontWeight.w600),
                  const SizedBox(height: 10),
                  AppText.appText(
                    "Don't panic. You can also customise this permission by going to Settings.",
                    fontSize: 14,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w400,
                    textColor: const Color(0xff4D5874),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  customLableField(
                    height: 52.0,
                    lable: "Name of Company *",
                    hintText: "University of the Punjab",
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: accounts.length,
                      itemBuilder: (context, index) {
                        return _buildAccountCard(
                          account: accounts[index],
                          index: index,
                          isSelected: _selectedIndex == index,
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButton.appButton("Add New Bank",
                          context: context,
                          width: ScreenSize(context).width * 0.42,
                          onTap: () {},
                          backgroundColor: const Color(0xffECEEF3),
                          border: false,
                          textColor: AppTheme.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      AppButton.appButton("Withdraw",
                          context: context,
                          width: ScreenSize(context).width * 0.42, onTap: () {
                        if (_selectedIndex != null) {
                          Navigator.pop(context);
                          // Trigger withdrawal logic here
                        }
                      },
                          backgroundColor: AppTheme.primaryCOlor,
                          border: false,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountCard({
    required Account account,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: ScreenSize(context).width,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? account.color : const Color(0xffE7E7E7),
            width: isSelected ? 2.0 : 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: account.color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(account.icon, color: account.color, size: 20),
              ),
              const SizedBox(width: 16),
              Text(account.name,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500)),
              const Spacer(),
              Radio<int>(
                value: index,
                groupValue: _selectedIndex,
                onChanged: (int? value) {
                  setState(() {
                    _selectedIndex = value;
                  });
                },
                activeColor: account.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Account {
  final String name;
  final IconData icon;
  final Color color;

  Account({
    required this.name,
    required this.icon,
    required this.color,
  });
}