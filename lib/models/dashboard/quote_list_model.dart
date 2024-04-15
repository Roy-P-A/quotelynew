class QuoteListModel {
  String id;
  String quote;

  QuoteListModel({
    required this.id,
    required this.quote,
  });
}

class QuoteListModel1 {
  String id;

  String quote;
  bool isRead;

  QuoteListModel1(
      {required this.id, required this.quote, required this.isRead});

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quote': quote,
      'isRead': isRead,
    };
  }

  //static fromJson(Map<String, dynamic> jsonMap) {}  

  factory QuoteListModel1.fromJson(Map<String, dynamic> jsonMap) {
    return QuoteListModel1(
      id: jsonMap['id'],
      quote: jsonMap['quote'],
      isRead: jsonMap['isRead'],
    );
  }  
}
