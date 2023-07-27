class UserModel {
  String? email;
  String? name;
  String? avatar;
  String? phone;
  bool? gender;
  String? address;
  String? referralId;
  String? dob;
  String? user_code;
  String? country;
  bool? isDeleted;
  bool? isAdmin;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? bCoin;
  bool? checkPackageUseTreePot;

  UserModel({
    this.email,
    this.name,
    this.avatar,
    this.phone,
    this.gender,
    this.address,
    this.country,
    this.isDeleted,
    this.isAdmin,
    this.createdAt,
    this.updatedAt,
    this.dob,
    this.referralId,
    this.bCoin,
    this.checkPackageUseTreePot,
    this.user_code
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'],
        name: json['name'],
        avatar: json['avatar'],
        phone: json['phone'],
        gender: json['gender'],
        address: json['address'],
        country: json['country'],
        isDeleted: json['isDeleted'],
        isAdmin: json['isAdmin'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        referralId: json['referralId'],
        dob: json['dob'],
        user_code: json['user_code'],
        bCoin: json['bcoin'],
        checkPackageUseTreePot: json['checkPackageUseTreePot'],
      );

  Map<String, dynamic> toJson() => {
        'email': this.email,
        'name': this.name,
        'avatar': this.avatar,
        'phone': this.phone,
        'gender': this.gender,
        'address': this.address,
        'country': this.country,
        'isDeleted': this.isDeleted,
        'isAdmin': this.isAdmin,
        'createdAt': this.createdAt,
        'updatedAt': this.updatedAt,
        'dob': this.dob,
        'user_code':this.user_code,
        'bcoin': this.bCoin,
        'referralId': this.referralId,
        'checkPackageUseTreePot': this.checkPackageUseTreePot,
      };

  @override
  String toString() {
    return 'UserModel{email: $email, name: $name, avatar: $avatar, phone: $phone, gender: $gender, address: $address, country: $country, isDeleted: $isDeleted, isAdmin: $isAdmin, createdAt: $createdAt, updatedAt: $updatedAt, bcoin:$bCoin, dob:$dob, checkPackageUseTreePot:$checkPackageUseTreePot}';
  }
}
