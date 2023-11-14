class UserModal {
  int? id;
  String? email;
  String? name;
  String? phone;
  String? whatsappNumber;
  String? idCardNumber;
  String? theJob;
  String? theAddress;
  String? governorate;
  String? cityCenter;
  String? previousExperience;
  String? username;
  int? isAdmin;
  int? isActive;
  bool? isVoted;
  int? ban;
  int? old;

  UserModal({
    this.id,
    this.email,
    this.phone,
    this.ban,
    this.cityCenter,
    this.governorate,
    this.idCardNumber,
    this.isActive,
    this.name,
    this.whatsappNumber,
    this.username,
    this.theJob,
    this.isVoted,
    this.theAddress,
    this.previousExperience,
    this.old,
    this.isAdmin,
  });

  UserModal.fromJson({required Map<String, dynamic> data}) {
    id = data['id'];
    name = data['name'];
    email = data['email'];
    whatsappNumber = data['whatsapp_number'];
    idCardNumber = data['id_card_number'];
    theJob = data['the_job'];
    theAddress = data['the_address'];
    governorate = data['governorate'];
    cityCenter = data['city_center'];
    previousExperience = data['previous_experience'];
    ban = data['ban'];
    isVoted = data['voted'];
    username = data['username'] ?? 'متطوع';
    isAdmin = data['is_admin'];
    isActive = data['is_active'];
    old = data['old'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'whatsapp_number': whatsappNumber,
      'id_card_number': idCardNumber,
      'the_job': theJob,
      'the_address': theAddress,
      'governorate': governorate,
      'city_center': cityCenter,
      'voted': isVoted,
      'previous_experience': previousExperience,
      'username': username,
      'is_admin': isAdmin,
      'is_active': isActive,
      'ban': ban,
      'old': old,
    };
  }
}
