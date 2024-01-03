
import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? status;
  int? code;
  String? message;
  Meta? meta;
  Data? data;

  LoginModel({
    this.status,
    this.code,
    this.message,
    this.meta,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    meta: Meta.fromJson(json["meta"]),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "meta": meta!.toJson(),
    "data": data!.toJson(),
  };
}

class Data {
  int? id;
  String? code;
  String? email;
  String? name;
  String? lastName;
  String? fullName;
  String? token;
  String? image;
  String? companyId;
  int? roleId;
  String? roleName;
  String? address;
  String ?consine;
  String ?emailSend;
  String? lang;
  int? countryId;
  String? countryName;
  int? notificationCount;
  List<String> ?listEmail;
  String ?phone;
  LastOrder ?lastOrder;
  int? orderCount;

  Data({
    this.id,
    this.code,
    this.email,
    this.name,
    this.lastName,
    this.fullName,
    this.token,
    this.image,
    this.companyId,
    this.roleId,
    this.roleName,
    this.address,
    this.consine,
    this.emailSend,
    this.lang,
    this.countryId,
    this.countryName,
    this.notificationCount,
    this.listEmail,
    this.phone,
    this.lastOrder,
    this.orderCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    code: json["code"],
    email: json["email"],
    name: json["name"],
    lastName: json["last_name"],
    fullName: json["full_name"],
    token: json["token"],
    image: json["image"],
    companyId: json["company_id"],
    roleId: json["role_id"],
    roleName: json["role_name"],
    address: json["address"],
    consine: json["consine"],
    emailSend: json["email_send"],
    lang: json["lang"],
    countryId: json["country_id"],
    countryName: json["country_name"],
    notificationCount: json["notification_count"],
    listEmail: List<String>.from(json["list_email"].map((x) => x)),
    phone: json["phone"],
    lastOrder: LastOrder.fromJson(json["last_order"]),
    orderCount: json["order_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "email": email,
    "name": name,
    "last_name": lastName,
    "full_name": fullName,
    "token": token,
    "image": image,
    "company_id": companyId,
    "role_id": roleId,
    "role_name": roleName,
    "address": address,
    "consine": consine,
    "email_send": emailSend,
    "lang": lang,
    "country_id": countryId,
    "country_name": countryName,
    "notification_count": notificationCount,
    "list_email": List<dynamic>.from(listEmail!.map((x) => x)),
    "phone": phone,
    "last_order": lastOrder!.toJson(),
    "order_count": orderCount,
  };
}

class LastOrder {
  String ?no;
  String ?status;

  LastOrder({
    this.no,
    this.status,
  });

  factory LastOrder.fromJson(Map<String, dynamic> json) => LastOrder(
    no: json["no"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "no": no,
    "status": status,
  };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
  );

  Map<String, dynamic> toJson() => {
  };
}
