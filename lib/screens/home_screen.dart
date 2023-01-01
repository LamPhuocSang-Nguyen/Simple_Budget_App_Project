
import 'package:flutter/material.dart';
import 'package:simple_buget/Widgets/footer_widget.dart';
import '../Widgets/bar_chart.dart';
import '../data/data.dart';
import '../helpers/color_helper.dart';
import '../models/category_model.dart';
import '../models/expense_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(title: Text('Simple Budget'),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network("https://ybox.vn/ky-nang/tong-hop-10-website-cho-phep-download-anh-chat-luong-cao-mien-phi-cho-nhung-thiet-ke-tuyet-voi-mnllhqmbjx",
                  fit: BoxFit.cover,),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent],
                      )
                    ),
                  )
                ],
              ),
            ),
            leading: IconButton(
              iconSize: 10,
              icon: Icon(Icons.settings),
              onPressed: (){},
            ),
            actions: [
              IconButton(
                iconSize: 10.0,
                onPressed: (){},
                icon: Icon(Icons.add),
              )
            ],
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                      if(index==0){
                        return Container(
                            margin: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const[
                                    BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0,2),
                                        blurRadius: 6.0,),
                                ],
                              borderRadius: BorderRadius.circular(10.0),),

                            child: BarChart(
                            expense: weeklySpending
                            ),
                        );
                      } else {
                        final Category category = categories[index - 1];
                        double totalAmountSpend = 0;
                        for(Expense expense in category.expenses){
                          totalAmountSpend += expense.cost;
                        }
                        return _buildCategoty(context, category, totalAmountSpend);
                }
              },
                childCount: categories.length + 1),
          ),
SliverToBoxAdapter(child: FooterWidget(),)
      ],)
    );
  }

  Widget _buildCategoty(
      BuildContext context, Category category, double totalAmountSpend){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow:const [
          BoxShadow(
          color: Colors.black38, offset: Offset(0,2),blurRadius: 6.0),
      ],
      borderRadius: BorderRadius.circular(10.0)),
    child: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    ),
          Text(
            '\$${totalAmountSpend.toStringAsFixed(2)}/${category.maxAmount}',
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
    )
        ],
    ),
       const SizedBox(height: 10,),
      LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints){
            final double maxBarWidth = constraints.maxWidth;
            final double percent =
            (category.maxAmount - totalAmountSpend) / category.maxAmount;
            double barWidth = percent * maxBarWidth;
            if (barWidth < 0){
              barWidth = 0;
            }
            return Stack(
              children: [
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Container(
                  width: barWidth,
                    height: 20,
                  decoration: BoxDecoration(
                    color: getColor(context, percent),
                    borderRadius: BorderRadius.circular(15),),
                ),
              ],
            );
          }
      )
    ],
    )
      );
  }
}
