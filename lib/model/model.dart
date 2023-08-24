class questions {
  String? question;
  String? a;
  String? b;
  String? c;
  String? d;
  String? answer;

  questions({this.question, this.a, this.b, this.c, this.d, this.answer});

  questions.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    a = json['A'];
    b = json['B'];
    c = json['C'];
    d = json['D'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['A'] = this.a;
    data['B'] = this.b;
    data['C'] = this.c;
    data['D'] = this.d;
    data['answer'] = this.answer;
    return data;
  }
}