import 'package:digitalMenuCustomer/Model/menuModel.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final Menu menu;
  ListCard({@required this.menu});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(20, 0, 5, 0),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(menu.name),
            Text(
              "₹ ${menu.price}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        trailing: CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(
            Icons.arrow_right_alt_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
