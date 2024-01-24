import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomeAlertDialog extends StatefulWidget {
  @override
  _CustomeAlertDialogState createState() => _CustomeAlertDialogState();
}

class _CustomeAlertDialogState extends State<CustomeAlertDialog> with SingleTickerProviderStateMixin {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            height: 230,
            decoration: ShapeDecoration(color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0), child: Text('আপনি কি অ্যাাপ থেকে বের হতে চাচ্ছেন ?', style: kalpurus.copyWith(fontSize: 17))),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 100,
                        decoration: BoxDecoration(color: Colors.green.withOpacity(.3), borderRadius: BorderRadius.circular(8)),
                        child: TextButton(
                          child: Text('হ্যাঁ', style: kalpurus.copyWith(fontSize: 16)),
                          onPressed: () {
                            exit(0);
                          },
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(color: Colors.green.withOpacity(.5), borderRadius: BorderRadius.circular(8)),
                        child: TextButton(
                          child: Text('না', style: kalpurus.copyWith(fontSize: 16)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
