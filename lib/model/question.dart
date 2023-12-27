import 'dart:convert';

class Question {
  int? Qid;
  String question;
  List<dynamic> option;
  int Cid;
  String Answer;

  Question(
      {required this.question,
        required this.option,
        required this.Cid,
        required this.Answer});


  Map<String, dynamic> toJson() {
    return {
      "Qid": this.Qid,
      "question": this.question,
      "option": jsonEncode(this.option),
      "Cids": this.Cid,
      "Answer": this.Answer,
    };
  }

  Question.withID(
      {required this.Qid,
        required this.question,
        required this.option,
        required this.Cid,
        required this.Answer});

  factory Question.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("Qid") &&
        json.containsKey("Question") &&
        json.containsKey("Option") &&
        json.containsKey("Cids") &&
        json.containsKey("Answer")) {
      return Question.withID(
        Qid: json["Qid"] as int,
        question: json["Question"] as String,
        option: jsonDecode(json["Option"]), // Store the entire "Option" field as a single string
        Cid: json["Cids"] as int,
        Answer: json["Answer"] as String,
      );
    } else {
      throw FormatException("Invalid JSON data or missing keys.");
    }
  }

//
}
