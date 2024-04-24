class UserModel {
  String? uid;
  String? fname;
  String? lname;
  String? email;

  UserModel({
    required this.uid,
    required this.fname,
    required this.lname,
    required this.email,
  });

  // Serialize data to json
  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'first_name': fname,
      'last_name': lname,
      'email': email,
    };
  }

  // Deserialize Json data to object recieved from cloud firestore
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['id'],
      fname: json['first_name'] as String?,
      lname: json['last_name'] as String?,
      email: json['email'].toString(),
    );
  }
}
