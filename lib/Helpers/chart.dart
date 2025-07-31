import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
