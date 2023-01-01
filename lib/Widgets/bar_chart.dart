import 'package:flutter/material.dart';
import 'package:simple_buget/data/data.dart';

class  BarChart extends StatelessWidget {
  final List<double> expense;

  final List<String> weeklyLabel = const[
    'mo',
    'tus',
    'wed',
    'thus',
    'fri',
    'sat',
    'sun',

];
  const BarChart({Key? key, required this.expense}) : super(key: key);

  List<Widget> _buildingWeeklySpendingList(){
    //find max element
    double mostExpensive = 0;

    for (double price in expense) {
      if (price > mostExpensive) {
        mostExpensive = price;
      }
    }

    //Create temp list
    List<Widget> WeeklySpendingList = [];

    for (int i = 0; i < expense.length; i++) {
      WeeklySpendingList.add(
        Bar(
          label: weeklyLabel[i],
          amountSpent: expense[i],
          mostExpensive: mostExpensive,
        ),
      );
    }

    return WeeklySpendingList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Weekly Spending',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
        ),
        ),

        Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
            const Expanded(
                child: Center(
                  child: Text(
                   'Jun 05, 2022 -jun 11, 2022',
    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
    ),
                  ),
                ),
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
          ],
        ),
        Row(
        children: _buildingWeeklySpendingList(),
    )
      ],
    );
  }
}


class Bar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpensive;

  final double _maxBarHeight = 100;

  const Bar({Key? key, this.label='', this.amountSpent=0, this.mostExpensive=0,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive + _maxBarHeight;

    return Column(
      children: [
        Text('\$${amountSpent.toStringAsFixed(2)}',
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600
        )
      ),
    const SizedBox(
      height: 0,
    ),
    Container(
    height: barHeight,
    width: 10,
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(6)
    ),
    ),
    const SizedBox(height: 6,),
    Text(label,style: const TextStyle(
        fontSize: 15,
    fontWeight: FontWeight.w600,
    ))
    ],
    );
  }
}

