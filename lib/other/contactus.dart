import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUS extends StatefulWidget {
  const ContactUS({super.key});

  @override
  State<ContactUS> createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
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
            'Contact Us',
            style: TextStyle(
                shadows: [
                  Shadow(
                    blurRadius: 10.0, // shadow blur
                    color: Color.fromARGB(255, 223, 71, 45), // shadow color
                    offset: Offset(2.0, 2.0), // how much shadow will be shown
                  ),
                ],
                fontSize: 20.sp,
                decorationColor: Colors.red,
                color: Color.fromARGB(255, 194, 97, 33),
                // color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Indian Natinal Kennel Club",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Indian National Kennel Club is one of the oldest kennel club in India. INKC is a non-profit organization founded in 1957. The motto Dogs for a Good Life … A Good Life for Dogs is apt for all dog lovers. Any queries from dog lovers are always welcome!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Web Address         : ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () async {
                        var url = Uri.parse("https://www.inkc.in");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Text(
                        "www.inkc.in",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 230, 10, 10),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Address                  : ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      width: 120.sp,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "2nd Floor,\nBelvedere Court,\nOpposite Oval Maidan,\n148 Maharshi Karve Road,\nChurchgate,\n Mumbai – 400020",
                            style: TextStyle(
                                color: Color.fromARGB(255, 29, 11, 11),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          // Text("Map"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8, bottom: 8),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bussiness Hours   :  ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      child: Text(
                        "Monday - Friday - 9AM to 5PM\nSaturday - 9AM to 2PM\nSunday - Closed",
                        style: TextStyle(
                            color: Color.fromARGB(255, 29, 11, 11),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Office                       : ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () async {
                        var url = Uri.parse("tel:+912222029106");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Text(
                        "+912222029106",
                        style: TextStyle(
                            color: Color.fromARGB(255, 113, 10, 230),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Support                    : ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () async {
                        var url = Uri.parse("tel:+919920864080");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Text(
                        "+919920864080",
                        style: TextStyle(
                            color: Color.fromARGB(255, 113, 10, 230),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Registration             :  ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () async {
                        var url = Uri.parse("tel:+919820141328");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Text(
                        "+919820141328",
                        style: TextStyle(
                            color: Color.fromARGB(255, 113, 10, 230),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Customer Support  : ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () async {
                        var url = Uri.parse(
                            "mailto:<office@inkc.in>?subject=<subject>&body=<body>");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Text(
                        "office@inkc.in",
                        style: TextStyle(
                            color: Color.fromARGB(255, 230, 10, 10),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        ),
      );
    });
  }
}
