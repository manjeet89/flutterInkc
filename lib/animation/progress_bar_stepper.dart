
import 'package:flutter/material.dart';

class ProgressBarStepper extends StatefulWidget {
  const ProgressBarStepper({super.key});

  @override
  State<ProgressBarStepper> createState() => _ProgressBarStepperState();
}

class _ProgressBarStepperState extends State<ProgressBarStepper> {
  List title = ['Order Place', 'Order Shipped', 'Out for delivery', 'Delivered'];
  int step = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 223, 39, 39)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Column(
          children: [
            Text(
              'Order track',
              style: TextStyle(
                  fontSize: 14,
                  decorationColor: Color.fromARGB(255, 66, 47, 45),
                  color: Color.fromARGB(255, 48, 40, 35),
                  // color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 18.0,top: 10),
              child: Text("Tracking Number",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 18.0,top: 10),
              child: Text("GP12354879",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
            ),
            const Divider(),
            
            Container(
              height: 130,
              padding: const EdgeInsets.only(left: 16, right: 16,top: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        for (int i = 0; i < title.length - 1; i++)
                          Expanded(
                              child: Row(
                            children: [
                              circleStepper(i),
                              Expanded(child: LineSplitter(i))
                            ],
                          )),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: circleStepper(title.length),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Row(
                    children: [
                      for (int i = 0; i < title.length - 1; i++)
                        Expanded(
                          child: stepperTitle(i),
                        ),
                      stepperTitle(title.length - 1)
                    ],
                  ))
                ],
              ),
            ),
         
           const Divider(),
          const Padding(
              padding: EdgeInsets.only(left: 18.0, top: 10),
              child: Text(
                "Ordered Date and time",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 18.0, top: 1),
              child: Text(
                "23 oct 2024 11:30AM",
                style: TextStyle(
                    color: Color.fromARGB(255, 39, 35, 35),
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 18.0, top: 1),
              child: Text(
                ".\n.\n.\n.\n.",
                style: TextStyle(
                    color: Color.fromARGB(255, 39, 35, 35),
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 18.0, top: 10),
              child: Text(
                "Receiving Date and time",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 18.0, top: 1),
              child: Text(
                "27 oct 2024 02:30PM",
                style: TextStyle(
                    color: Color.fromARGB(255, 39, 35, 35),
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget stepperTitle(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "STEP${index + 1}",
            style: TextStyle(
                color: Colors.black.withOpacity(.3),
                fontSize: 8,
                fontWeight: FontWeight.bold),
          ),
          Text(
            title.elementAt(index),
            style: TextStyle(
                color:
                    index <= step ? const Color.fromARGB(255, 0, 0, 0) : Colors.black.withOpacity(.3),
                fontSize: 10,
                fontWeight: FontWeight.bold),
          ),
          stepperStatus(index)
        ],
      ),
    );
  }

  Widget stepperStatus(int index) {
    return Container(
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: index == step
              ? Colors.blueAccent.withOpacity(.4)
              : Colors.black.withOpacity(.1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            index == step
                ? "In Progess"
                : index < step
                    ? "Completed"
                    : "Pending ",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: index == step
                    ? Colors.blueAccent
                    : index < step
                        ? Colors.green
                        : Colors.black.withOpacity(.5),
                fontSize: 10,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget LineSplitter(int index) {
    return Container(
      width: double.infinity,
      height: 5,
      color: index < step ? const Color.fromARGB(255, 22, 172, 8) : Colors.black.withOpacity(.2),
    );
  }

  Widget circleStepper(int index) {
    return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.5),
            border: Border.all(
                color:
                    index > step ? Colors.black.withOpacity(.1) : Colors.black,
                width: 2,
                style: BorderStyle.solid)),
        child: Container(
            margin: EdgeInsets.all(index == step ? 2 : 0),
            alignment: const Alignment(0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: index > step ? Colors.black.withOpacity(.1) : const Color.fromARGB(255, 16, 185, 10),
            ),
            child: step > index
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 20,
                  )
                : step < index
                    ? Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black, width: 1)),
                      )
                    : Text(
                        '${index + 1}',
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      )));
  }
}
