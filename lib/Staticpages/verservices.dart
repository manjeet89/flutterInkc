import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Vetservices extends StatefulWidget {
  const Vetservices({super.key});

  @override
  State<Vetservices> createState() => _VetservicesState();
}

class _VetservicesState extends State<Vetservices> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon:
                Icon(Icons.arrow_back, color: Color.fromARGB(255, 223, 39, 39)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Vet Services',
            style: TextStyle(
                shadows: [
                  Shadow(
                    blurRadius: 10.0, // shadow blur
                    color: Color.fromARGB(255, 223, 71, 45), // shadow color
                    offset: Offset(2.0, 2.0), // how much shadow will be shown
                  ),
                ],
                fontSize: 18.sp,
                decorationColor: Colors.red,
                color: Color.fromARGB(255, 194, 97, 33),
                // color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            "Coming Soon",
            style: TextStyle(
                color: Colors.red,
                fontSize: 22.sp,
                fontWeight: FontWeight.w800),
          ),
        ),
      );
    });
  }
}
