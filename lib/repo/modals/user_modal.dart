class User {
  bool? status;
  String? message;
  UserData? user;
  int? code;

  User({this.status, this.message, this.user, this.code});

  User.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? UserData.fromJson(json['user']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['code'] = code;
    return data;
  }
}

class UserData {
  String? name;
  String? username;
  String? email;
  String? phone;
  String? whatsappNumber;
  String? idCardNumber;
  String? theJob;
  String? theAddress;
  String? governorate;
  String? cityCenter;
  int? old;
  int? isActive;
  int? isAdmin;
  String? previousExperience;
  int? id;
  int? code;
  String? expireAt;

  UserData(
      {this.name,
      this.email,
      this.phone,
      this.whatsappNumber,
      this.idCardNumber,
      this.theJob,
      this.theAddress,
      this.governorate,
      this.old,
      this.username,
      this.cityCenter,
      this.isActive,
      this.isAdmin,
      this.previousExperience,
      this.id,
      this.code,
      this.expireAt});

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    old = json['old'];
    whatsappNumber = json['whatsapp_number'];
    idCardNumber = json['id_card_number'];
    theJob = json['the_job'];
    theAddress = json['the_address'];
    governorate = json['governorate'];
    cityCenter = json['city_center'];
    isActive = json['is_active'];
    isAdmin = json['is_admin'];
    previousExperience = json['previous_experience'];
    id = json['id'];
    code = json['code'];
    expireAt = json['expire_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['old'] = old;
    data['whatsapp_number'] = whatsappNumber;
    data['id_card_number'] = idCardNumber;
    data['the_job'] = theJob;
    data['the_address'] = theAddress;
    data['governorate'] = governorate;
    data['city_center'] = cityCenter;
    data['is_active'] = isActive;
    data['is_admin'] = isAdmin;
    data['previous_experience'] = previousExperience;
    data['id'] = id;
    data['code'] = code;
    data['expire_at'] = expireAt;
    return data;
  }
}
