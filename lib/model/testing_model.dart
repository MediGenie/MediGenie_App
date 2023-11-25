class HistoryTakingTestingModel {
  int? index;
  String? title;
  int? order;
  List<QuestionModel>? questions = [];

  HistoryTakingTestingModel({
    this.index,
    this.title,
    this.order,
    this.questions,
  });

  factory HistoryTakingTestingModel.formJson(Map<String, dynamic> json) {
    return HistoryTakingTestingModel(
      index: json['index'],
      title: json['title'],
      order: json['order'],
      questions: (json['questions'] as List).map((e) => QuestionModel.formJson(e)).toList(),
    );
  }
}

class AddPhotoTestModel {
  int? index;
  String? title;
  String? category;
  List<QuestionModel>? questions = [];

  AddPhotoTestModel({
    this.index,
    this.title,
    this.category,
    this.questions,
  });

  factory AddPhotoTestModel.formJson(Map<String, dynamic> json) {
    return AddPhotoTestModel(
      index: json['index'] ?? 0,
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      questions: ((json['questions'] ?? []) as List).map((e) => QuestionModel.formJson(e)).toList(),
    );
  }
}

class QuestionModel {
  String? question;
  String? subtitle;
  bool? isReduplication;
  List<String>? answers = [];

  QuestionModel({
    this.question,
    this.subtitle,
    this.isReduplication,
    this.answers,
  });

  factory QuestionModel.formJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'],
      subtitle: json['subtitle'] ?? '',
      isReduplication: json['reduplication'] ?? false,
      answers: ((json['answers'] ?? []) as List).map((e) => e.toString()).toList(),
    );
  }
}

class TestResultModel {
  int? index;
  String? title;
  List<DiagnosisResultModel>? diagnosisResults = [];

  TestResultModel({
    this.index,
    this.title,
    this.diagnosisResults,
  });

  factory TestResultModel.formJson(Map<String, dynamic> json) {
    return TestResultModel(
      index: json['index'],
      title: json['title'],
      diagnosisResults: ((json['diagnosesresult'] ?? []) as List).map((e) => DiagnosisResultModel.formJson(e)).toList(),
    );
  }
}

class DiagnosisResultModel {
  String? key;
  String? background;
  String? title;
  String? type;

  DiagnosisResultModel({
    this.key,
    this.background,
    this.title,
    this.type,
  });

  factory DiagnosisResultModel.formJson(Map<String, dynamic> json) {
    return DiagnosisResultModel(
      key: json['key'],
      background: json['background'],
      title: json['title'],
      type: json['type'],
    );
  }
}

class HearingTestModel {
  int? index;
  String? title;
  String? category;
  List<HearingProgressModel>? hearingProgress = [];

  HearingTestModel({
    this.index,
    this.title,
    this.category,
    this.hearingProgress,
  });

  factory HearingTestModel.formJson(Map<String, dynamic> json) {
    return HearingTestModel(
      index: json['index'],
      title: json['title'],
      category: json['category'],
      hearingProgress: ((json['hearingProgress'] ?? []) as List).map((e) => HearingProgressModel.formJson(e)).toList(),
    );
  }
}

class HearingProgressModel {
  String? question;
  String? subtitle;
  String? progressType;
  int? stepCount;
  List<HearingAudioModel>? audioSound = [];

  HearingProgressModel({
    this.question,
    this.subtitle,
    this.progressType,
    this.stepCount,
    this.audioSound,
  });

  factory HearingProgressModel.formJson(Map<String, dynamic> json) {
    return HearingProgressModel(
      question: json['question'],
      subtitle: json['subtitle'] ?? '',
      progressType: json['progressType'] ?? '',
      stepCount: json['stepcount'] ?? 0,
      audioSound: ((json['audioProgress'] ?? []) as List).map((e) => HearingAudioModel.formJson(e)).toList(),
    );
  }
}

class HearingAudioModel {
  int? frequency, volume, step;
  String? status;

  HearingAudioModel({
    this.frequency,
    this.volume,
    this.status,
    this.step,
  });

  factory HearingAudioModel.formJson(Map<String, dynamic> json) {
    return HearingAudioModel(
      frequency: json['frequency'],
      volume: json['volume'],
      status: json['status'],
      step: json['step'],
    );
  }
}

class DiagnosisAIResultModel {
  int? resultId, prescriptionId, diagnosisId;
  String? name;
  String? description;
  String? code;
  Prescriptions? prescriptions;
  String? mgExplanation;
  String? severityLevel;
  String? department;

  DiagnosisAIResultModel({
    this.resultId,
    this.prescriptionId,
    this.diagnosisId,
    this.name,
    this.description,
    this.code,
    this.prescriptions,
    this.mgExplanation,
    this.severityLevel = '',
    this.department,
  });

  factory DiagnosisAIResultModel.formJson(Map<String, dynamic> json) {
    return DiagnosisAIResultModel(
      prescriptionId: json['id'],
      diagnosisId: json['diagnosis'],
      name: json['name'],
      description: json['description'],
      code: json['code'],
      prescriptions: Prescriptions.formJson(json['prescriptions'] ?? {}),
      mgExplanation: json['mgExplanation'],
      severityLevel: json['severityLevel'] ?? '',
      department: json['department'],
    );
  }
}

class Prescriptions {
  int? id;
  String? serious;
  String? treatment;
  String? medications;

  Prescriptions({
    this.id,
    this.serious,
    this.treatment,
    this.medications,
  });

  factory Prescriptions.formJson(Map<String, dynamic> json) {
    return Prescriptions(
      id: json['id'] ?? 0,
      serious: json['serious'],
      treatment: json['treatment'],
      medications: json['medications'],
    );
  }
}

class MedigenieAIResultServerModel {
  int? diagnosisId;
  String? historyTakingData;
  List<String> images;
  String? earPos;
  Map<String, dynamic> average;
  Map<String, dynamic> right;
  Map<String, dynamic> left;
  int? memberId = 0;

  MedigenieAIResultServerModel({
    this.diagnosisId = 0,
    this.historyTakingData = '',
    this.images = const [],
    this.earPos = '',
    this.average = const {},
    this.right = const {},
    this.left = const {},
    this.memberId = 0,
  });

  void setAverage({required int right, required int left}) {
    final aver = Map.of(average);
    aver['right'] = right;
    aver['left'] = left;
    average = aver;
  }

  void setRight({required int frequncy, required int volume}) {
    final r = Map.of(right);
    r[frequncy.toString()] = volume;
    right = r;
  }

  void setLeft({required int frequncy, required int volume}) {
    final l = Map.of(left);
    l[frequncy.toString()] = volume;
    left = l;
  }

  String convertAverage() {
    return '{"right":${average['right']},"left":${average['left']}}';
  }

  String convertRight() {
    String result = '';
    right.forEach((key, value) {
      result += '"$key":$value,';
    });
    return '{${result.substring(0, result.length - 1)}}';
  }

  String convertLeft() {
    String result = '';
    left.forEach((key, value) {
      result += '"$key":$value,';
    });
    return '{${result.substring(0, result.length - 1)}}';
  }
}
