import 'dart:convert';

Data dataFromMap(String str) => Data.fromMap(json.decode(str));

String dataToMap(Data data) => json.encode(data.toMap());

class Data {
  Data({
    this.problems,
  });

  final List<Problem>? problems;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    problems: json["problems"] == null ? null : List<Problem>.from(json["problems"].map((x) => Problem.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "problems": problems == null ? null : List<dynamic>.from(problems!.map((x) => x.toMap())),
  };
}

class Problem {
  Problem({
    this.diabetes,
    this.asthma,
  });

  final List<Diabetes>? diabetes;
  final List<Asthma>? asthma;

  factory Problem.fromMap(Map<String, dynamic> json) => Problem(
    diabetes: json["Diabetes"] == null ? null : List<Diabetes>.from(json["Diabetes"].map((x) => Diabetes.fromMap(x))),
    asthma: json["Asthma"] == null ? null : List<Asthma>.from(json["Asthma"].map((x) => Asthma.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "Diabetes": diabetes == null ? null : List<dynamic>.from(diabetes!.map((x) => x.toMap())),
    "Asthma": asthma == null ? null : List<dynamic>.from(asthma!.map((x) => x.toMap())),
  };
}

class Asthma {
  Asthma();

  factory Asthma.fromMap(Map<String, dynamic> json) => Asthma(
  );

  Map<String, dynamic> toMap() => {
  };
}

class Diabetes {
  Diabetes({
    this.medications,
    this.labs,
  });

  final List<Medication>? medications;
  final List<Lab>? labs;

  factory Diabetes.fromMap(Map<String, dynamic> json) => Diabetes(
    medications: json["medications"] == null ? null : List<Medication>.from(json["medications"].map((x) => Medication.fromMap(x))),
    labs: json["labs"] == null ? null : List<Lab>.from(json["labs"].map((x) => Lab.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "medications": medications == null ? null : List<dynamic>.from(medications!.map((x) => x.toMap())),
    "labs": labs == null ? null : List<dynamic>.from(labs!.map((x) => x.toMap())),
  };
}

class Lab {
  Lab({
    this.missingField,
  });

  final String? missingField;

  factory Lab.fromMap(Map<String, dynamic> json) => Lab(
    missingField: json["missing_field"] == null ? null : json["missing_field"],
  );

  Map<String, dynamic> toMap() => {
    "missing_field": missingField == null ? null : missingField,
  };
}

class Medication {
  Medication({
    this.medicationsClasses,
  });

  final List<MedicationsClass>? medicationsClasses;

  factory Medication.fromMap(Map<String, dynamic> json) => Medication(
    medicationsClasses: json["medicationsClasses"] == null ? null : List<MedicationsClass>.from(json["medicationsClasses"].map((x) => MedicationsClass.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "medicationsClasses": medicationsClasses == null ? null : List<dynamic>.from(medicationsClasses!.map((x) => x.toMap())),
  };
}

class MedicationsClass {
  MedicationsClass({
    this.className,
    this.className2,
  });

  final List<ClassName>? className;
  final List<ClassName>? className2;

  factory MedicationsClass.fromMap(Map<String, dynamic> json) => MedicationsClass(
    className: json["className"] == null ? null : List<ClassName>.from(json["className"].map((x) => ClassName.fromMap(x))),
    className2: json["className2"] == null ? null : List<ClassName>.from(json["className2"].map((x) => ClassName.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "className": className == null ? null : List<dynamic>.from(className!.map((x) => x.toMap())),
    "className2": className2 == null ? null : List<dynamic>.from(className2!.map((x) => x.toMap())),
  };
}

class ClassName {
  ClassName({
    this.associatedDrug,
    this.associatedDrug2,
  });

  final List<AssociatedDrug>? associatedDrug;
  final List<AssociatedDrug>? associatedDrug2;

  factory ClassName.fromMap(Map<String, dynamic> json) => ClassName(
    associatedDrug: json["associatedDrug"] == null ? null : List<AssociatedDrug>.from(json["associatedDrug"].map((x) => AssociatedDrug.fromMap(x))),
    associatedDrug2: json["associatedDrug#2"] == null ? null : List<AssociatedDrug>.from(json["associatedDrug#2"].map((x) => AssociatedDrug.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "associatedDrug": associatedDrug == null ? null : List<dynamic>.from(associatedDrug!.map((x) => x.toMap())),
    "associatedDrug#2": associatedDrug2 == null ? null : List<dynamic>.from(associatedDrug2!.map((x) => x.toMap())),
  };
}

class AssociatedDrug {
  AssociatedDrug({
    this.name,
    this.dose,
    this.strength,
  });

  final String? name;
  final String? dose;
  final String? strength;

  factory AssociatedDrug.fromMap(Map<String, dynamic> json) => AssociatedDrug(
    name: json["name"] == null ? null : json["name"],
    dose: json["dose"] == null ? null : json["dose"],
    strength: json["strength"] == null ? null : json["strength"],
  );

  Map<String, dynamic> toMap() => {
    "name": name == null ? null : name,
    "dose": dose == null ? null : dose,
    "strength": strength == null ? null : strength,
  };
}