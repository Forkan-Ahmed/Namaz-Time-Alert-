class AudioModel {
  late int suraNo;
  late String qareName, qareDetails, suraLink;

  AudioModel();

  AudioModel.fromMap(dynamic map) {
    this.suraNo = map['SURANO'];
    this.qareName = map['QARINAME'];
    this.qareDetails = map['QAREDETAILS']??"";
    this.suraLink = map['SURALINK'];
  }
}

class QareModel{

  late String banglaName;
  late String englishName;

  QareModel({this.banglaName='', this.englishName=''});
}
