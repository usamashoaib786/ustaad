import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';

class SessionCard extends StatelessWidget {
  final String title, fee, time;
  final Color? color;
  final String? days;
  final String? toDate;
  final String? duration;
  final String? fromDate;

  final bool isCompleted;
  final String? rating; // Only used if isCompleted = true

  const SessionCard({
    super.key,
    required this.title,
    this.duration,
    required this.fee,
    required this.time,
    this.color,
    this.days,
    required this.isCompleted,
    this.rating,
    this.toDate,
    this.fromDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 185,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:
              isCompleted == true ? AppTheme.appColor : color ?? Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.appText(title,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                textColor: isCompleted == true
                    ? AppTheme.white
                    : color != null
                        ? AppTheme.white
                        : AppTheme.black),
            const SizedBox(height: 4),
            if (isCompleted == true)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppText.appText("From",
                          textColor: AppTheme.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      const SizedBox(width: 5),
                      Image.asset(
                        "assets/images/dot.png",
                        height: 5,
                        color: isCompleted == true
                            ? AppTheme.white
                            : color != null
                                ? AppTheme.white
                                : AppTheme.grey,
                      ),
                      const SizedBox(width: 5),
                      AppText.appText(fromDate!,
                          textColor: AppTheme.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      AppText.appText("To",
                          textColor: AppTheme.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      const SizedBox(width: 5),
                      Image.asset(
                        "assets/images/dot.png",
                        height: 5,
                        color: isCompleted == true
                            ? AppTheme.white
                            : color != null
                                ? AppTheme.white
                                : AppTheme.grey,
                      ),
                      const SizedBox(width: 5),
                      AppText.appText(toDate!,
                          textColor: AppTheme.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                  const SizedBox(height: 15),
                  AppText.appText(fee,
                      textColor: isCompleted == true
                          ? AppTheme.white
                          : color != null
                              ? AppTheme.white
                              : AppTheme.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ],
              ),
            if (isCompleted != true)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.appText(duration!,
                      textColor: color != null ? AppTheme.white : AppTheme.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/dot.png",
                        height: 5,
                        color: color != null ? AppTheme.white : AppTheme.grey,
                      ),
                      const SizedBox(width: 5),
                      AppText.appText(fee,
                          textColor:
                              color != null ? AppTheme.white : AppTheme.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ],
                  )
                ],
              ),
            const SizedBox(height: 10),
            if (isCompleted != true)
              AppText.appText(days!,
                  textColor: color != null ? AppTheme.white : AppTheme.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            const SizedBox(height: 15),
            isCompleted
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      AppText.appText(rating ?? "0.0",
                          textColor: AppTheme.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ],
                  )
                : AppText.appText(time,
                    textColor:
                        color != null ? AppTheme.white : AppTheme.appColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
          ],
        ),
      ),
    );
  }
}
