class OjifaModel {
  late int topicNo, subtopicNo;
  late String name, araby, banglaMeaning, banglaTranslator, fozilot, niyom;

  OjifaModel(
      {this.topicNo = 0,
      this.subtopicNo = 0,
      this.name = '',
      this.araby = '',
      this.banglaMeaning = '',
      this.banglaTranslator = '',
      this.fozilot = '',
      this.niyom = ''});

  OjifaModel.fromMap(dynamic map) {
    topicNo = map['TOPICNO'];
    subtopicNo = map['SUBTOPICNO'];
    name = map['NAME'];
    araby = map['ARABI'];
    banglaMeaning = map['BANGLAMEANING'];
    banglaTranslator = map['BANGLATRANSLATOR'];
    fozilot = map['FOZILOT']??"";
    niyom = map['NIYOM']??"";
  }

  @override
  String toString() {
    return 'OjifaModel{topicNo: $topicNo, subtopicNo: $subtopicNo, name: $name, araby: $araby, banglaMeaning: $banglaMeaning, banglaTranslator: $banglaTranslator, fozilot: $fozilot, niyom: $niyom}';
  }
}
