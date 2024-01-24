import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/home_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/widget/custom_button.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

class CalendarScreen extends StatelessWidget {
  Widget titleWidget(String key, String value, {double left = 16, double right = 0, double top = 3, double bottom = 0}) {
    return value != null
        ? Container(
            padding: EdgeInsets.only(left: left, top: top, bottom: bottom, right: right),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(key, style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
                SizedBox(width: 10),
                Expanded(flex: 4, child: Text(value, style: TextStyle(fontSize: 16, color: Colors.black)))
              ],
            ),
          )
        : SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Strings.calendar)),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) => ListView(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          physics: BouncingScrollPhysics(),
          children: [
            Text('আজকের তারিখঃ', style: kalpurus.copyWith(fontSize: 17, fontWeight: FontWeight.w600)),
            titleWidget('আরবিঃ', homeProvider.arabyDate),
            titleWidget('বাংলাঃ', homeProvider.banglaDate),
            titleWidget('ইংরেজিঃ', homeProvider.englishDate),
            SizedBox(height: 20),
            CustomButton(
                onTap: () {
                  _showDatePicker(ctx: context, homeProvider: homeProvider);
                },
                buttonText: 'Date Convert'),
            homeProvider.narabyDate.length>0?
            Text('সিলেক্টকৃত তারিখঃ', style: kalpurus.copyWith(fontSize: 17, fontWeight: FontWeight.w600)):SizedBox.shrink(),
            homeProvider.narabyDate.length>0?titleWidget('আরবিঃ', homeProvider.narabyDate):SizedBox.shrink(),
            homeProvider.narabyDate.length>0?titleWidget('বাংলাঃ', homeProvider.nbanglaDate):SizedBox.shrink(),
            homeProvider.narabyDate.length>0?titleWidget('ইংরেজিঃ', homeProvider.nenglishDate):SizedBox.shrink(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future _showDatePicker({ctx, HomeProvider? homeProvider}) async {
    DateTime? newDateTime = await showRoundedDatePicker(
      context: ctx,
      height: 300,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      initialDate: homeProvider!.selectDateTime,
      firstDate: DateTime(DateTime.now().year - 10),
      //lastDate: DateTime.now().add(Duration(seconds: 1)),
      borderRadius: 2,
    );

    if (newDateTime != null) {
      homeProvider.queryDate(newDateTime);
    }
  }
}
