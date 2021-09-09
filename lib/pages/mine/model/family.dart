class family{
  var familyname;
  var familystatue;
  var familybool;
  family(json){
    familyname =json['name'];
    familystatue =json['statue'];
    familybool =json['bool'];
  }
}