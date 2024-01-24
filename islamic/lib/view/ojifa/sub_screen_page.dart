import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/data/model/ojifa_model.dart';
import 'package:search_islam/provider/ojifa_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/widget/custom_app_bar.dart';

class SubScreenScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Provider.of<OjifaProvider>(context, listen: false).initializeAllOjifa(1);

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            child: CustomAppBar(title: 'কালেমা'), preferredSize: Size(MediaQuery.of(context).size.width, 70)),
        body: Consumer<OjifaProvider>(
          builder: (context, ojifaProvider, child) => ListView.builder(
              itemCount: ojifaProvider.getAllOjifaModel.length,
              padding: EdgeInsets.symmetric(vertical: 10),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => _titleWidget(ojifaModel: ojifaProvider.getAllOjifaModel[index], context: context)),
        ),
      ),
    );
  }

  Widget _titleWidget({required OjifaModel ojifaModel, required BuildContext context}) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.01), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 3))],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: Column(
        children: <Widget>[
          InkWell(
            child: Row(
              children: <Widget>[
                SvgPicture.asset(Images.ojifa_svg, height: 30, width: 30),
                Expanded(child: Center(child: Text('${ojifaModel.name}', style: TextStyle(color: Colors.black, fontSize: 20, height: 1.8)))),
              ],
            ),

          ),
          SizedBox(height: 5),
          Container(
              height: 3,
              decoration:
                  BoxDecoration(gradient: LinearGradient(colors: [const Color(0xffffffff), const Color(0xFF0270EE), const Color(0xffffffff)])))
        ],
      ),
    );
  }
}
