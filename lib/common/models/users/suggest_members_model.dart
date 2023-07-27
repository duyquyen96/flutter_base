class SuggestMembersModel {
  String? userId;
  String? email;
  String? avatar;
  String? nickname;
  String? language;

  SuggestMembersModel(
      {this.userId, this.email, this.avatar, this.nickname, this.language});

  factory SuggestMembersModel.fromJson(Map<String, dynamic> json) {
    return SuggestMembersModel(
      userId: json["user_id"] ?? json["user_id"],
      email: json["email"] ?? "",
      avatar: json["avatar"] ?? "",
      nickname: json["nickname"] ?? 0,
      language: json["language"],
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "email": email,
        "avatar": avatar,
        "language": language,
        "nickname": nickname
      };
}
