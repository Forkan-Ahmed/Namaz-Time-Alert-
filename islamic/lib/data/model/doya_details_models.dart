class DoyaDetailsModels {
  int slNo = 0, globalId = 0;
  String id = '', arabic = '', banglaMeaning = '', banglaTranslator = '', niyom = '', reference = '', bottom = '';

  DoyaDetailsModels(
      {this.id = '',
      this.slNo = 0,
      this.globalId = 0,
      this.arabic = '',
      this.banglaMeaning = '',
      this.banglaTranslator = '',
      this.niyom = '',
      this.reference = '',
      this.bottom = ''});

  DoyaDetailsModels.fromMap(dynamic map) {
    this.id = map['ID'] ?? "";
    this.slNo = map['SL_NO'] ?? 0;
    this.globalId = map['GLOBAL_ID'] ?? 0;
    this.arabic = map['ARABIC'] ?? "";
    this.banglaMeaning = map['BANGLA_MEANING'] ?? "";
    this.banglaTranslator = map['BANGLA_TRANSLATOR'] ?? "";
    this.niyom = map['NIYOM'] ?? "";
    this.reference = map['REFERENCE'] ?? "";
    this.bottom = map['BOTTOM'] ?? "";
  }
}
