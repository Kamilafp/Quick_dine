class User{
  int? id;
  String? name;
  String? email;
  String? notelp;
  String? role;
  String? image;
  String? token;
  int? idKantin;

User({
    this.id,
    this.name,
    this.email,
    this.notelp,
    this.role,
    this.image,
    this.token,
    this.idKantin,
});

  // function to convert json data to user model
  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      notelp: json['user']['notelp'],
      role: json['user']['role'],
      image: json['user']['image'],
      token: json['token'],
      idKantin: json['id_kantin'],
    );
  }
}