import 'package:medi_genie/model/diagosis_page_model.dart';

class MediGeniePageModel {
  int? id;
  String? title;
  DiagosisPageModel? diagnosis;

  MediGeniePageModel({
    this.id,
    this.title,
    this.diagnosis,
  });

  factory MediGeniePageModel.fromJson(Map<String, dynamic> json) => MediGeniePageModel(
      id: json['id'],
      title: json['title'],
      diagnosis: DiagosisPageModel.fromJson(
        json['diagnosis'],
      ));
}
