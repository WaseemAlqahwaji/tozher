import 'package:flutter/material.dart';
import 'package:tozher/features/goals/domain/entity/goal.dart';

class GoalItem extends StatelessWidget {
  final Goal goal;
  const GoalItem({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // Row(
          //   children: [
          //     Expanded(
          //       child: Container(
          //         decoration: BoxDecoration(
          //           color: Theme.of(context).primaryColor.withValues(alpha: .1),
          //         ),
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Text(goal.isPrivate ? "Private" : "Public"),
          //         ),
          //       ),
          //     ),
          //     IconButton(onPressed: (){}, icon: Icon(Icons.menu_outlined))
          //   ],
          // ),
        ],
      ),
    );
  }
}
