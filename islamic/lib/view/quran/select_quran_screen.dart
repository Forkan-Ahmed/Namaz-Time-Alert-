import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/utill/app_constants.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/quran/quran_details_screen.dart';
import 'package:search_islam/view/quran/sura_para_list_screen.dart';
import 'package:search_islam/widget/custom_app_bar.dart';

class SelectQuranScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<QuraanShareefProvider>(context, listen: false).changeAvailableFileStatus();

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(child: CustomAppBar(title: Strings.quran_sharif), preferredSize: Size(MediaQuery.of(context).size.width, 120)),
        body: ListView(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(colors: [Colors.blueAccent, Colors.blueAccent.withOpacity(.8), Colors.blueAccent]),
                boxShadow: [
                  BoxShadow(color: Colors.blueAccent.withOpacity(0.1), spreadRadius: 3, blurRadius: 3, offset: Offset(0, 3) // changes position of shadow
                      )
                ],
              ),
              child: Consumer<QuraanShareefProvider>(
                builder: (context,quranProvider,child)=>InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => QuranDetailsScreen(
                          suraID:  quranProvider.suraModel.suraNo,
                          title: quranProvider.suraModel.banglaTranslator,
                          paraModel: null,
                          isFromSuraScreen: true ,
                        )));
                  },
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 13),
                          Text(Strings.sorboses_pora_hoyeche, style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                          SizedBox(height: 3),
                          Row(
                            children: [
                              Text('${Strings.sura} ', style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                              Text('${quranProvider.suraModel.banglaTranslator}',
                                  style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(height: 3),
                          Text('${Strings.probesh_korun} >>', style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                        ],
                      ),
                      Positioned(right: 0, bottom: 0, child: SvgPicture.asset(Images.quran_svg, width: 80, height: 80))
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)]),
                boxShadow: [
                  BoxShadow(color: Colors.blueAccent.withOpacity(0.1), spreadRadius: 3, blurRadius: 3, offset: Offset(0, 3) // changes position of shadow
                      )
                ],
              ),
              child: Text(
                '${Strings.pocondo_onujaye_jekono}',
                textAlign: TextAlign.center,
                style: kalpurus.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
            _itemCategoryWidget(
                title: Strings.sura_krome,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => SuraParaListScreen(title: Strings.sura_krome)));
                },
                context: context),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            _itemCategoryWidget(
                title: Strings.para_krome,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => SuraParaListScreen(title: Strings.para_krome, isShowSura: false)));
                },
                context: context),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            _itemCategoryWidget(
                title: Strings.hafeji_quran,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => SuraParaListScreen(title: Strings.para_krome, isShowSura: false, isShowHafejiQuranSystem: true)));
                },
                context: context),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

          ],
        ),
      ),
    );
  }

  Widget _itemCategoryWidget({required BuildContext context,  String? title, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap!,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
          color: Colors.blueAccent,
          boxShadow: [BoxShadow(color: Colors.blueAccent.withOpacity(0.1), spreadRadius: 3, blurRadius: 3, offset: Offset(0, 3))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title!, style: kalpurus.copyWith(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 17)),
            Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
