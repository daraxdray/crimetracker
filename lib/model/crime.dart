
class Crime {
  int id;
  String cName;
  String cDescription;
  String cLocation;
  String longLat;
  String img;
  String img2;
  String img3;
  String date;

  Crime({ required this.id,
  required this.cName,
  required this.cDescription,
  required this.cLocation,
  required this.longLat,
  required this.img,
  required this.img2,
  required this.img3,
  required this.date
});

  factory Crime.fromMap(Map<dynamic,dynamic> data) => new Crime(
    id: data['id'],
    cName : data['cName'],
    cDescription : data['cDescription'],
    cLocation : data['cLocation'],
    longLat : data['cCurrLocation'],
    img : data['img'],
    img2 : data['img2'],
    img3 : data['img3'],
    date : data['dateCreated'],
  );

 factory Crime.fromDb(Map<dynamic,dynamic> data) => new Crime(id: data['eid'],
    cName : data['eName'],
    cDescription : data['eDescription'],
    cLocation : data['eLocation'],
    longLat : data['eCurrLocation'],
    img : data['eImg'],
    img2 : data['eImg2'],
    img3 : data['eImg3'],
    date : data['dateCreated']
  );

  Map <String,dynamic> toDb(){
    var map = <String, Object> {
    'eName' : this.cName,
    'eDescription' : this.cDescription,
    'eLocation' : this.cLocation,
    'eCurrLocation' : this.longLat,
    'eImg' : this.img,
    'eImg2' : this.img2,
    'eImg3' : this.img3,
     'dateCreated': this.date
    };
    return map;
  }

}