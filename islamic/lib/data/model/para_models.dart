class ParaModel{
  late int paraNo;
  late String nameAraby,nameEnglish,nameBangla;
  late String audioSudais,audioGumadi,audioBudair,audioAlajmi,audioMishary;

  ParaModel({this.paraNo=0, this.nameAraby='', this.nameEnglish='', this.nameBangla='',
      this.audioSudais=''});

  ParaModel.formMap(dynamic map){
    this.paraNo=map['PARANO'];
    this.nameAraby=map['NAME_ARABI'];
    this.nameEnglish=map['NAME_ENGLISH'];
    this.nameBangla=map['NAME_BANGLA'];
    this.audioSudais=map['AUDIO_SUDAIS'];
    this.audioGumadi=map['SAD_AL_GUAMIDI'];
    this.audioBudair=map['SALAH_BUDIR'];
    this.audioAlajmi=map['AHMED_AL_AJMI'];
    this.audioMishary=map['MISHARY'];
  }

}