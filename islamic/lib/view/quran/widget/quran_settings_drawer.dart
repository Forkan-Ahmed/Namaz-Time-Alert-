import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/data/model/audio_model.dart';
import 'package:search_islam/data/model/key_model.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';

class QuranSettingsDrawer extends StatelessWidget {
  final bool isShowHafejiQuran;

  QuranSettingsDrawer({this.isShowHafejiQuran = false});

  @override
  Widget build(BuildContext context) {
    Provider.of<QuraanShareefProvider>(context, listen: false).initializeAllQare();
    Provider.of<QuraanShareefProvider>(context, listen: false).initializeAllArabicStyle();
    Provider.of<QuraanShareefProvider>(context, listen: false).initializeAllFontStyle();
    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.white, Colors.white])),
      width: MediaQuery.of(context).size.width * 0.80,
      child: Consumer<QuraanShareefProvider>(
          builder: (context, quranProvider, child) => ListView(
                padding: EdgeInsets.all(20),
                physics: BouncingScrollPhysics(),
                children: [
                  // font size
                  Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(color: Colors.green.shade100, spreadRadius: 1, blurRadius: 5)],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Text('${Strings.change_font_size}', style: kalpurus.copyWith(fontWeight: FontWeight.w700))),
                            CircleAvatar(
                                child: Text('${quranProvider.fontSize}', style: kalpurus.copyWith(fontWeight: FontWeight.w700, color: Colors.white))),
                          ],
                        ),
                        SliderTheme(
                            data: SliderThemeData(
                                disabledActiveTrackColor: Colors.blue,
                                disabledInactiveTrackColor: Colors.black12,
                                trackHeight: 10,
                                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
                                trackShape: RoundedRectSliderTrackShape()),
                            child: Slider(
                                autofocus: true,
                                value: quranProvider.fontSize,
                                onChanged: quranProvider.changeFontSize,
                                min: 10,
                                max: 30,
                                divisions: 20,
                                label: '${quranProvider.fontSize}')),
                      ],
                    ),
                  ),

                  // araby font
                  isShowHafejiQuran
                      ? SizedBox.shrink()
                      : Container(
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.green.shade100, spreadRadius: 1, blurRadius: 5)],
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${Strings.arabic_font_select_korun}', style: kalpurus.copyWith(fontWeight: FontWeight.w700)),
                              DropdownButton<KeyModel>(
                                items: quranProvider.fontStyles.map((fontStyle) {
                                  return new DropdownMenuItem<KeyModel>(value: fontStyle, child: new Text(fontStyle.value, style: poppinsRegular));
                                }).toList(),
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                value: quranProvider.fontStyleKeyModel,
                                onChanged: (fontStyle) {
                                  quranProvider.changeFontStyle(fontStyle!);
                                },
                              ),
                            ],
                          ),
                        ),

                  // choose option
                  isShowHafejiQuran
                      ? SizedBox.shrink()
                      : Container(
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.green.shade100, spreadRadius: 1, blurRadius: 5)],
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              CheckboxListTile(
                                  title: Text(Strings.arabi), value: quranProvider.isShowArabic(), onChanged: (value){
                                quranProvider.updateArabicStatus(value!);
                              }),
                              CheckboxListTile(
                                  title: Text(Strings.bangla_meaning),
                                  value: quranProvider.isShowBanglaMeaning(),
                                  onChanged: (value){
                                    quranProvider.updateBanglaMeaningStatus(value!);
                                  }),
                              CheckboxListTile(
                                  title: Text(Strings.bangla_uccaron),
                                  value: quranProvider.isShowBanglaTranslate(),
                                  onChanged:(value){
                                    quranProvider.updateBanglaTranslateStatus(value!);
                                  }),
                              CheckboxListTile(
                                  title: Text(Strings.other), value: quranProvider.isShowOther, onChanged: (value){
                                quranProvider.updateOtherStatus(value!);
                              }),
                            ],
                          ),
                        ),

                  // qare select korun
                  isShowHafejiQuran
                      ? SizedBox.shrink()
                      : Container(
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.green.shade100, spreadRadius: 1, blurRadius: 5)],
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${Strings.kare_nirbacon_korun}', style: kalpurus.copyWith(fontWeight: FontWeight.w700)),
                              DropdownButton<QareModel>(
                                items: quranProvider.qares.map((qareModel) {
                                  return new DropdownMenuItem<QareModel>(
                                      value: qareModel, child: new Text(qareModel.banglaName, style: poppinsRegular));
                                }).toList(),
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                value: quranProvider.qareModel,
                                onChanged: (qare) {
                                  quranProvider.changeQareName(qare!);
                                },
                              ),
                            ],
                          ),
                        ),

                  // araby Style Change korun
                  isShowHafejiQuran
                      ? SizedBox.shrink()
                      : Container(
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.green.shade100, spreadRadius: 1, blurRadius: 5)],
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${Strings.change_style_for_only_arabic}', style: kalpurus.copyWith(fontWeight: FontWeight.w700)),
                              DropdownButton<KeyModel>(
                                items: quranProvider.arabyStyles.map((quranStyle) {
                                  return new DropdownMenuItem<KeyModel>(
                                      value: quranStyle, child: new Text(quranStyle.keyName, style: poppinsRegular));
                                }).toList(),
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                value: quranProvider.arabicStyleKeyModel,
                                onChanged: (arabicStyle) {
                                  quranProvider.changeArabicStyle(arabicStyle!);
                                },
                              ),
                            ],
                          ),
                        ),
                ],
              )),
    );
  }
}
