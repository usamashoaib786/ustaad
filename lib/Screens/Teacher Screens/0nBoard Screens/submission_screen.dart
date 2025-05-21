import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';

class SubmissionCompleteScreen extends StatelessWidget {
  const SubmissionCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Green checkmark icon
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.withOpacity(0.1),
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(
                  Icons.check_circle,
                  size: 48,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 24),

              // Main title
              AppText.appText(
                "You're Done From Your Side!",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                textColor: Colors.black,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Subtext
              AppText.appText(
                "Let us verify your submission. Meanwhile you can have a look at your App. Hope you’ll have a wonderful time",
                fontSize: 14,
                textColor: Colors.grey,
                textAlign: TextAlign.center,
                maxlines: 3,
              ),

              const SizedBox(height: 32),

              // Custom Button
              AppButton.appButton(
                "Go to Dashboard",
                context: context,
                backgroundColor: Colors.transparent,
                textColor: Colors.blue,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                border: true,
                borderColor: Colors.grey.shade300,
                onTap: () {
                  // Your navigation or logic here
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
