import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';

class TutorExperience extends StatefulWidget {
  const TutorExperience({super.key});

  @override
  State<TutorExperience> createState() => _TutorExperienceState();
}

class _TutorExperienceState extends State<TutorExperience> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerRight,
            child: AppButton.appButton(
              "Add Experience",
              image: "assets/images/plus.png",
              context: context,
              onTap: () {
                // showModalBottomSheet(
                //   backgroundColor: AppTheme.white,
                //   context: context,
                //   isScrollControlled: true,
                //   isDismissible: false, // 👈 disable tap outside to close
                //   enableDrag: false, // 👈 disable drag down to close
                //   shape: const RoundedRectangleBorder(
                //     borderRadius:
                //         BorderRadius.vertical(top: Radius.circular(20)),
                //   ),
                //   builder: (context) => const AddEducationBottomSheet(),
                // );
              },
              height: 36,
              width: 125,
              textColor: AppTheme.white,
              borderColor: AppTheme.appColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            )),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppTheme.appColor,
                        image: DecorationImage(image: AssetImage("assets/images/joblogo.png",), fit: BoxFit.fill)
                      ),
                    ),
                    SizedBox(
                      width: ScreenSize(context).width - 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          const Text(
                            'Beacon House School',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text(
                                'January 2022 — Today',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'Full-time',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Bullet points with different lengths
                          _buildBulletPoint(
                            'Designed X feature from the discovery phase to the delivery phase. '
                            'After launch this feature moved X metric by 8% for new users.',
                          ),
                          const SizedBox(height: 12),
                          _buildBulletPoint(
                            'Contributed to product requirement documents for our revenue team '
                            'to help align us on strategy.',
                          ),
                          const SizedBox(height: 12),
                          _buildBulletPoint(
                            'Designed and documented new components for our design system '
                            'so they could be used by the entire design team.',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 4, right: 8),
          child: Icon(
            Icons.circle,
            size: 8,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
