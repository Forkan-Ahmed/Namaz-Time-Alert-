import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/location_provider.dart';
import 'package:search_islam/provider/prayer_time_provider.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/widget/show_custom_snakbar.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Provider.of<QuraanShareefProvider>(context, listen: false)
        .initializeAllFontStyle();
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Consumer3<LocationProvider, PrayerTimeProvider,
          QuraanShareefProvider>(
        builder: (context, locationProvider, prayerTimeProvider, quranProvider,
                child) =>
            ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          children: [
            // zila Nirbacon
            Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.green.shade100,
                        spreadRadius: 1,
                        blurRadius: 5)
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${Strings.zila_nirbacon_korun}',
                    style: kalpurus.copyWith(fontWeight: FontWeight.w700),
                  ),
                  DropdownButton<String>(
                    items:
                        locationProvider.allDistrictName.map((String district) {
                      return new DropdownMenuItem<String>(
                        value: district,
                        child: new Text(district, style: poppinsRegular),
                      );
                    }).toList(),
                    isExpanded: true,
                    underline: SizedBox.shrink(),
                    value: locationProvider.getDistrictName(),
                    onChanged: (value) {
                      showCustomSnackBar('Selected District: $value', context);
                      locationProvider.setDistrictName(value!);
                    },
                  ),
                ],
              ),
            ),
            // SizedBox(height: 15),
            // madhab nirbacon korun
            Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.green.shade100,
                        spreadRadius: 1,
                        blurRadius: 5)
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${Strings.namajer_jonno_madhab_select_korun}',
                    style: kalpurus.copyWith(fontWeight: FontWeight.w700),
                  ),
                  DropdownButton<String>(
                    items: ['hanafi', 'shafi'].map((String district) {
                      return new DropdownMenuItem<String>(
                        value: district,
                        child: new Text(
                          district,
                          style: poppinsRegular,
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    underline: SizedBox.shrink(),
                    value: prayerTimeProvider.getMajhabName(),
                    onChanged: (value) {
                      showCustomSnackBar('Selected Madhab: $value', context);
                      prayerTimeProvider.saveMajhabName(value!);
                      prayerTimeProvider.initializeCurrentPrayerTime();
                      prayerTimeProvider.initializeAllMonthPrayerTimeData();
                      prayerTimeProvider.initializeTommorwPrayerTime();
                    },
                  ),
                ],
              ),
            ),
            //SizedBox(height: 15),

          ],
        ),
      ),
    );
  }
}
