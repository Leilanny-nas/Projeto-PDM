class UrubankUser {
  String? id;
  String? avatar;
  String name;
  String cpf;
  String email;
  String birthDate;
  String phoneNumber;
  Map<String, dynamic> account;

  UrubankUser({
    this.id,
    this.avatar,
    required this.name,
    required this.cpf,
    required this.email,
    required this.phoneNumber,
    required this.account,
    required this.birthDate,
  });

  factory UrubankUser.fromJson(Map<String, dynamic> json) {
    return UrubankUser(
      id: json.containsKey('id') ? json['id'] : null,
      avatar: json.containsKey('avatar') ? json['avatar'] : null,
      name: json['name'],
      cpf: json['cpf'],
      email: json['email'],
      account: json['account'],
      phoneNumber: json['phoneNumber'],
      birthDate: json['birthDate'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "cpf": cpf,
        "email": email,
        "account": account,
        "phoneNumber": phoneNumber,
        "birthDate": birthDate,
      };
}
