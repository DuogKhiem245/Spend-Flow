class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String phoneNumber;
  final DateTime? dob; 
  final String? photoUrl;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.phoneNumber = '',
    this.dob,
    this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'dob': dob,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      dob: map['dob'] != null ? (map['dob'] as dynamic).toDate() : null,
      photoUrl: map['photoUrl'],
    );
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? phoneNumber,
    DateTime? dob,
    String? photoUrl,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dob: dob ?? this.dob,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
