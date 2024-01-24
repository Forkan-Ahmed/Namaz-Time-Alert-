class DoyaNameModels {
  int globalId = 0, category = 0, duaId = 0;
  String name = '', id = '';

  DoyaNameModels({this.globalId = 0, this.category = 0, this.duaId = 0, this.name = '', this.id = ''});

  DoyaNameModels.fromMap(dynamic map) {
    this.globalId = map['GLOBAL_ID'];
    this.category = map['CATEGORY'];
    this.duaId = map['DUYA_ID'];
    this.name = map['NAME'];
    this.id = map['ID'];
  }
}
