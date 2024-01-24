import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/location_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/settings/settings_screen.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool isLocation;
  final bool isBackgroundPrimaryColor;
  final bool isAyatScreen;
  final  GlobalKey<ScaffoldState>? drawerKey;
  final bool isShowHafejiQuran;
  final bool isQuranSoundScreen;
  final bool isZakatScreen;

  CustomAppBar(
      {this.title='',
      this.isLocation = false,
      this.isBackgroundPrimaryColor = false,
      this.isAyatScreen = false,
      this.drawerKey,
      this.isShowHafejiQuran = false,
      this.isQuranSoundScreen = false,
      this.isZakatScreen = false});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(isBackgroundPrimaryColor ? 0 : 30), bottomRight: Radius.circular(isBackgroundPrimaryColor ? 0 : 30)),
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [const Color(0xFF0270EE), const Color(0xFF0000e6)])),
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            Expanded(child: Text(title, style: poppinsMedium.copyWith(color: Colors.white, fontSize: 15))),
            isLocation
                ? InkWell(
              onTap: () {
                //Navigator.of(context).push(MaterialPageRoute(builder: (_) => SettingsScreen()));
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.location_on, color: Colors.white),
                  Text('| ${Provider.of<LocationProvider>(context).getDistrictName()}   ',
                      style: poppinsRegular.copyWith(color: Colors.white, fontSize: 17))
                ],
              ),
            ):SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _shururKotha() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Text(Strings.quran_ke_sohoje_bujar_poddote_title, style: kalpurus.copyWith(fontSize: 17, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Divider(height: 2, thickness: 2, color: Colors.green),
            SizedBox(height: 5),
            Text(Strings.quran_ke_sohoje_bujar_poddote_details, style: kalpurus.copyWith(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter state) {
            return SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(Strings.zakater_hisab_kivabe_korben_title,
                              style: kalpurus.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 20),
                        Text(Strings.zakater_hisab_kivabe_korben_details, style: kalpurus.copyWith(fontSize: 18, fontWeight: FontWeight.w400)),
                      ],
                    )));
          });
        });
  }
}
