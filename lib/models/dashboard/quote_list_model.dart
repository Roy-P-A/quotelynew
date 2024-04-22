class QuoteListModel {
  String id;
  String quote;

  QuoteListModel({
    required this.id,
    required this.quote,
  });

  factory QuoteListModel.fromJson(Map<String, dynamic> jsonMap) {
    return QuoteListModel(
      id: jsonMap['id'],
      quote: jsonMap['quote'],
    );
  }  

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quote': quote,
    };
  }

}

class QuoteListModel1 {
  String id;
  String quote;
  bool isFavourite ;

  QuoteListModel1(
      {required this.id, required this.quote,  this.isFavourite = false});

      

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quote': quote,
      'isFavourite': isFavourite,
    };
  }

  //static fromJson(Map<String, dynamic> jsonMap) {}  

  factory QuoteListModel1.fromJson(Map<String, dynamic> jsonMap) {
    return QuoteListModel1(
      id: jsonMap['id'],
      quote: jsonMap['quote'],
      isFavourite: jsonMap['isFavourite'],
    );
  }  
}
