import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({super.key});

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon:
                const Icon(Icons.arrow_back, color: Color.fromARGB(255, 223, 39, 39)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Digital Presence',
            style: TextStyle(
                shadows: const [
                  Shadow(
                    blurRadius: 10.0, // shadow blur
                    color: Color.fromARGB(255, 223, 71, 45), // shadow color
                    offset: Offset(2.0, 2.0), // how much shadow will be shown
                  ),
                ],
                fontSize: 20.sp,
                decorationColor: Colors.red,
                color: const Color.fromARGB(255, 194, 97, 33),
                // color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'The Indian National Kennel Club can be found on following social media.',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp),
              ),
            ),
            Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        var url =
                            'https://www.facebook.com/IndianNationalKennelClub';
                        if (await canLaunch(url)) {
                          await launch(
                            url,
                            universalLinksOnly: true,
                          );
                        } else {
                          throw 'There was a problem to open the url: $url';
                        }
                      },
                      child: Container(
                        width: 80.sp,
                        height: 80.sp,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: AssetImage("assets/face.png"),
                            fit: BoxFit.cover, //change image fill type
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        var url = 'https://www.instagram.com/inkcdogs/';
                        if (await canLaunch(url)) {
                          await launch(
                            url,
                            universalLinksOnly: true,
                          );
                        } else {
                          throw 'There was a problem to open the url: $url';
                        }
                      },
                      child: Container(
                        width: 80.sp,
                        height: 80.sp,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: AssetImage("assets/insta.png"),
                            fit: BoxFit.cover, //change image fill type
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        var url = 'https://twitter.com/inkcdogs';
                        if (await canLaunch(url)) {
                          await launch(
                            url,
                            universalLinksOnly: true,
                          );
                        } else {
                          throw 'There was a problem to open the url: $url';
                        }
                      },
                      child: Container(
                        width: 80.sp,
                        height: 80.sp,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: AssetImage("assets/twit.png"),
                            fit: BoxFit.cover, //change image fill type
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          var url =
                              'https://api.whatsapp.com/send/?phone=919820141328';
                          if (await canLaunch(url)) {
                            await launch(
                              url,
                              universalLinksOnly: true,
                            );
                          } else {
                            throw 'There was a problem to open the url: $url';
                          }
                        },
                        child: Container(
                          width: 80.sp,
                          height: 80.sp,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage("assets/what.png"),
                              fit: BoxFit.cover, //change image fill type
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          var url =
                              'https://www.youtube.com/channel/UC3xS08MoMxq0q4QjAOB24_Q';
                          if (await canLaunch(url)) {
                            await launch(
                              url,
                              universalLinksOnly: true,
                            );
                          } else {
                            throw 'There was a problem to open the url: $url';
                          }
                        },
                        child: Container(
                          width: 75.sp,
                          height: 75.sp,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage("assets/you.png"),
                              fit: BoxFit.cover, //change image fill type
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: InkWell(
                        onTap: () async {
                          var url = 'https://www.linkedin.com/company/inkc/';
                          if (await canLaunch(url)) {
                            await launch(
                              url,
                              universalLinksOnly: true,
                            );
                          } else {
                            throw 'There was a problem to open the url: $url';
                          }
                        },
                        child: Container(
                          width: 75.sp,
                          height: 75.sp,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage("assets/link.png"),
                              fit: BoxFit.cover, //change image fill type
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ),
          ],
        ),
      );
    });
  }
}
