import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final size;
  const MyBarrier({super.key,
  this.size});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(width: 10,color: Color.fromARGB(255, 52, 110, 54)),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}