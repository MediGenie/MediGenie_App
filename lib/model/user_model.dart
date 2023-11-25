class UserModel {
  int? id = 0;
  String? username, email, uuid;
  bool? isGuest, isFirst;
  UserPersnalInfoMedel? userPersnalInfoMedel = UserPersnalInfoMedel();
  List<UserFamilyMemberModel>? userFamilyMemberModels = [];
  List<UserDiagnosisResultModel>? userDiagnosisResultModels = [];

  UserModel({
    this.id,
    this.username,
    this.email,
    this.uuid,
    this.isGuest,
    this.isFirst,
    this.userPersnalInfoMedel,
    this.userFamilyMemberModels,
    this.userDiagnosisResultModels,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        uuid: json['uuid'],
        isGuest: json['isGuest'],
        isFirst: json['isFirst'],
        userPersnalInfoMedel: UserPersnalInfoMedel(
          gender: json['gender'],
          ageCategory: json['ageCategory'],
          serviceAgreedDate: DateTime.parse(json['serviceAgreedDate'] ?? DateTime.now().toString()),
          privacyPolicyAgreedDate: DateTime.parse(json['privacyPolicyAgreedDate'] ?? DateTime.now().toString()),
          birthDate: DateTime.parse(json['birthDate'] ?? DateTime.now().toString()),
        ),
        userFamilyMemberModels: json['familyMembers'] != null
            ? (json['familyMembers'] as List).map((e) => UserFamilyMemberModel.fromJson(e)).toList()
            : [],
        userDiagnosisResultModels: json['diagnosisResults'] != null
            ? (json['diagnosisResults'] as List).map((e) => UserDiagnosisResultModel.fromJson(e)).toList()
            : [],
      );

  bool getFirstUser() => isFirst ?? true;
  bool getChildExist() => userFamilyMemberModels!.where((element) => element.type == 'CHILD').isNotEmpty;
}

class UserPersnalInfoMedel {
  String? gender, ageCategory;
  DateTime? serviceAgreedDate, privacyPolicyAgreedDate, birthDate;

  UserPersnalInfoMedel({
    this.gender,
    this.ageCategory,
    this.serviceAgreedDate,
    this.privacyPolicyAgreedDate,
    this.birthDate,
  });
}

class UserFamilyMemberModel {
  int? id;
  String? name, birthDate, type, gender;

  UserFamilyMemberModel({
    this.id,
    this.name,
    this.birthDate,
    this.type,
    this.gender,
  });

  factory UserFamilyMemberModel.fromJson(Map<String, dynamic> json) => UserFamilyMemberModel(
        id: json['id'],
        name: json['name'],
        birthDate: json['birthDate'],
        type: json['type'],
        gender: json['gender'],
      );
}

class UserDiagnosisResultModel {
  int? id, diagnosisId;
  String? createdAt, department;
  List<UserPrescriptions>? prescriptions;
  UserFamilyMemberModel? userFamilyMemberModel;

  UserDiagnosisResultModel({
    this.id,
    this.createdAt,
    this.diagnosisId,
    this.department,
    this.prescriptions,
    this.userFamilyMemberModel,
  });

  factory UserDiagnosisResultModel.fromJson(Map<String, dynamic> json) => UserDiagnosisResultModel(
        id: json['id'],
        createdAt: json['createdAt'],
        diagnosisId: json['diagnosis']['id'] ?? 0,
        department: json['diagnosis']['department'] ?? '',
        prescriptions: json['prescriptions'] != null
            ? (json['prescriptions'] as List).map((e) => UserPrescriptions.formJson(e)).toList()
            : [],
        userFamilyMemberModel: UserFamilyMemberModel.fromJson(json['familyMember'] ?? {}),
      );
}

class UserPrescriptions {
  int? id;
  String? name;
  String? severityLevel;
  String? department;

  UserPrescriptions({
    this.id,
    this.name,
    this.severityLevel,
    this.department,
  });

  factory UserPrescriptions.formJson(Map<String, dynamic> json) {
    return UserPrescriptions(
      id: json['id'] ?? 0,
      name: json['name'],
      severityLevel: json['severityLevel'],
      department: json['department'],
    );
  }
}
