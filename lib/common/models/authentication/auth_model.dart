class AuthModel {
  String? accessToken;

  AuthModel({
    this.accessToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        accessToken: json['token'],
      );
  factory AuthModel.fromJsonStorage(Map<String, dynamic> json) => AuthModel(
        accessToken: json['accessToken'],
      );

  Map<String, dynamic> toJson() => {
        'accessToken': this.accessToken,
      };

  @override
  String toString() {
    return 'AuthModel{accessToken: $accessToken}';
  }
}
