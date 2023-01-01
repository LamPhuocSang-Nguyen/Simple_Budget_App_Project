import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_buget/models/expense_model.dart';
import '../models/category_model.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;

  const CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();


}

class _CategoryScreenState extends State<CategoryScreen> {

  @override
  Widget build(BuildContext context) {
    double totalAmountSpend = 0;
    for (Expense expense in widget.category.expenses){
      totalAmountSpend += expense.cost;
    }
    final double amountLeft = widget.category.maxAmount - totalAmountSpend;
    final double percent = amountLeft / widget.category.maxAmount;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Colum(
          children: [

          ]
        ),
      ),
    )
  }
}
class RadialPainter extends CustomPainter{

  final Color bgColor;
  final Color lineColor;
  final double width;
  final double percent;

  RadialPainter({
    this.bgColor = Colors.transparent,
    this.lineColor = Colors.transparent,
    this.percent = 0.0,
    this.width = 0.0,
});


  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint bgLine = Paint()
    ..color = bgColor
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke
    ..strokeWidth = width;

    Paint completeLine = Paint()
    ..color = lineColor
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke
    ..strokeWidth = width;

    Offset center = Offset(size.width / 2,size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, bgLine);


    double sweepAngle = 2 * pi * percent;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, sweepAngle, false, completeLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }}

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
