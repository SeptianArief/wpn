import 'package:flutter/material.dart';

class DashboardTopbarWidget extends StatelessWidget {
  const DashboardTopbarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          offset: const Offset(0.0, 1.0), //(x,y)
          blurRadius: 6.0,
        ),
      ]),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Admin',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              Text(
                'Admin',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              )
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.arrow_drop_down_rounded,
            color: Colors.black54,
          )
        ],
      ),
    );
  }
}
