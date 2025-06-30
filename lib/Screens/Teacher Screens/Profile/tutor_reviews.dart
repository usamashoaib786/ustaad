import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/custom%20widgets/ratings.dart';

class TutorReviews extends StatefulWidget {
  const TutorReviews({super.key});

  @override
  State<TutorReviews> createState() => _TutorReviewsState();
}

class _TutorReviewsState extends State<TutorReviews> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.appText("Usama Shoaib",
                fontSize: 16, fontWeight: FontWeight.w400),
            SizedBox(
              height: 10,
            ),
            RatingStars(rating: 4.6),
            SizedBox(
              height: 10,
            ),
            AppText.appText(
                "I am writing this review four months after the project was completed. During this time, there were minor errors, but the team addressed them immediately. Overall, everything is functioning reliably. We continue to collaborate.z",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textColor: Color(0xff3E3E3E)),
            SizedBox(
              height: 20,
            )
          ],
        );
      },
    );
  }
}
