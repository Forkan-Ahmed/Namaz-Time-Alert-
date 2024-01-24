import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_islam/utill/color_resources.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/home/widget/category_widget.dart';
import 'package:search_islam/view/home/widget/drawer.dart';
import 'package:search_islam/view/ojifa/sub_screen_page.dart';
import 'package:search_islam/view/tasbih/tasbih_screen.dart';
import 'package:search_islam/widget/custome_dialog.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xFF0270EE), statusBarBrightness: Brightness.dark));

    return WillPopScope(
      onWillPop: () {
        showDialog(context: context, builder: (_) => CustomeAlertDialog());
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: CustomDrawer(),
        appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.menu, color: ColorResources.primaryColor),
            onPressed: () {},
          ),
          title: Text(Strings.apps_name, style: poppinsMedium.copyWith(color: ColorResources.primaryColor, fontSize: 18)),
          actions: [

          ],
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          children: [
            // for namajer time
            //PrayerTimeWidget(),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                CategoryWidget(title: Strings.quran_sharif, iconUrl: Images.quran_svg, isSvg: false),
                CategoryWidget(title: Strings.doya, iconUrl: Images.dua_svg),
                CategoryWidget(title: Strings.kalema, iconUrl: Images.ojifa_svg, routeWidget: SubScreenScreen(),isSvg: false),
                CategoryWidget(title: Strings.prayer_time, iconUrl: Images.prayer_time_svg,isSvg: false),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryWidget(title: Strings.zakat, iconUrl: Images.zakat_svg, isSvg: false),
                CategoryWidget(title: Strings.kibla, iconUrl: Images.kabba_svg, ),
                CategoryWidget(title: Strings.tasbih, iconUrl: Images.tasbih_svg, routeWidget: TasbihScreen(),isSvg: false),
                CategoryWidget(title: Strings.calendar, iconUrl: Images.calendar_svg,),
              ],


            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                CategoryWidget(title: Strings.janun, iconUrl: Images.info_svg,),
                CategoryWidget(title: Strings.off_korun, iconUrl: Images.close_svg,),
              ],
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
