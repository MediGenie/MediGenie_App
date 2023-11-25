class DiagosisPageModel {
  int? id, diagnosisDuration;
  String? department, diagnosisCategory, jsonLink, subject;

  DiagosisPageModel({
    this.id,
    this.department,
    this.diagnosisCategory,
    this.diagnosisDuration,
    this.jsonLink,
    this.subject,
  });

  factory DiagosisPageModel.fromJson(Map<String, dynamic> json) =>
      DiagosisPageModel(
          id: json['id'],
          department: json['department'],
          diagnosisCategory: json['diagnosisCategory'],
          diagnosisDuration: json['diagnosisDuration'],
          jsonLink: json['jsonLink'],
          subject: json['subject']);
}
