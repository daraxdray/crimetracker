class User {
  String? email;
  String? name;
  String? phone;
  String? address;
  String? password;
  String? createdAt;
  int? id;
  String? token;

  User(
      {this.email,
        this.name,
        this.phone,
        this.address,
        this.password,
        this.createdAt,
        this.id});

  User.fromJson(Map<dynamic, dynamic> json) {
    email = json['uEmail'];
    name = json['uName'];
    phone = json['uPhone'];
    address = json['uAddress'];
    password = json['uPassword'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['password'] = this.password;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
 Map<String, dynamic> toDb() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uEmail'] = this.email;
    data['uName'] = this.name;
    data['uPhone'] = this.phone;
    data['uAddress'] = this.address;
    data['uPassword'] = this.password;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }


  factory User.fromDb(Map<dynamic,dynamic> json) => new User(id: json['id'],
      email : json['email'],
      name : json['name'],
      phone : json['phone'],
      address : json['address'],
      createdAt : json['created_at'],
  );

}

//{
//"user": {
//"email": "DamilolaDaramola@trashcoin.com.ng",
//"name": "Damilola Daramola",
//"phone": "08105259928",
//"address": "efumadami",
//"lat": "92.2222",
//"lng": "19.2222",
//"updated_at": "2020-07-08T22:41:39.000000Z",
//"created_at": "2020-07-08T22:41:39.000000Z",
//"id": 202
//},
//"token": "1|tf0NVEtDnNKHteDm42Dpkt4WdX70UHrm0blg5Hp6HDU6Jf9kVCqViLXgK5TLPHcQie4X4WthOQZkVFBb"
//}