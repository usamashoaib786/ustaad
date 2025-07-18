import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Screens/Drawer/tutor_drawer.dart';
import 'package:ustaad/custom%20widgets/app_bar.dart';
import 'package:ustaad/custom%20widgets/seesion_cards.dart';

class TutorDashBoardScreen extends StatefulWidget {
  const TutorDashBoardScreen({super.key});

  @override
  State<TutorDashBoardScreen> createState() => _TutorDashBoardScreenState();
}

class _TutorDashBoardScreenState extends State<TutorDashBoardScreen> {
  String selectedMonth = 'March';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: SideMenuDrawer(
        crossOnTap: () {
          _scaffoldKey.currentState?.closeEndDrawer();
        },
        isTutor: true,
      ),
      appBar: CustomAppBar(
        onMenuTap: () {
          _scaffoldKey.currentState?.openEndDrawer();
        },
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.appText("Your Balance",
                      fontSize: 16, fontWeight: FontWeight.w400),
                  const SizedBox(height: 8),
                  AppText.appText("Rs. 12,312.00",
                      fontSize: 44, fontWeight: FontWeight.w600),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600]),
                      children: [
                        TextSpan(text: 'Balance for the month of '),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedMonth,
                              isDense: true,
                              menuWidth: 125,
                              padding: EdgeInsets.all(0),
                              items: months.map((month) {
                                return DropdownMenuItem<String>(
                                  value: month,
                                  child: Text(
                                    month,
                                    style: TextStyle(
                                      color: Colors.teal,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                              icon: Icon(Icons.keyboard_arrow_down,
                                  size: 20, color: Colors.teal),
                              onChanged: (value) {
                                setState(() {
                                  selectedMonth = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.appText("Upcoming Sessions",
                          fontSize: 16, fontWeight: FontWeight.w600),
                      AppText.appText("View All",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          textColor: Color(0xffA4B0BE)),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  SessionCard(
                    title: "Class at Mr Ali's House",
                    duration: '1 hr Session',
                    fee: 'Rs. 15000/mo',
                    days: "Mon-Fri",
                    time: '12h : 34m : 12s',
                    color: AppTheme.primaryCOlor,
                    isCompleted: false,
                  ),
                  const SizedBox(width: 12),
                  SessionCard(
                    title: "Class at Mir Ahmed's House",
                    duration: '2 hr Session',
                    fee: 'Rs. 17000/mo',
                    days: "Mon-Fri",
                    time: '14h : 34m : 12s',
                    isCompleted: false,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  AppText.appText("Weekly Productivity",
                      fontSize: 16, fontWeight: FontWeight.w600),
                  SizedBox(
                    width: 10,
                  ),
                  AppText.appText("(12 March - 19 March)",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      textColor: Color(0xffB0B0B0)),
                ],
              ),
            ),
            EarningsBarChart(),
          ],
        ),
      ),
    );
  }
}

class EarningsBarChart extends StatelessWidget {
  const EarningsBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: AspectRatio(
        aspectRatio: 1.4,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  width: 1, color: Color.fromARGB(255, 208, 206, 206))),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Earnings",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                const SizedBox(height: 30),
                Expanded(
                  child: BarChart(
                    BarChartData(
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 50000,
                            getTitlesWidget: (value, _) => Text(
                              '${(value ~/ 1000)}k',
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, _) {
                              const months = [
                                'Jan',
                                'Feb',
                                'Mar',
                                'Apr',
                                'May',
                                'Jun'
                              ];
                              return Text(months[value.toInt()],
                                  style: const TextStyle(fontSize: 10));
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      barGroups: [
                        makeGroupData(0, 120000),
                        makeGroupData(1, 230000),
                        makeGroupData(2, 130000),
                        makeGroupData(3, 225000),
                        makeGroupData(4, 100000),
                        makeGroupData(5, 150000),
                      ],
                      gridData: FlGridData(show: true),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 20,
          borderRadius: BorderRadius.circular(6),
          color: const Color(0xFF20bf6b),
        )
      ],
    );
  }
}
