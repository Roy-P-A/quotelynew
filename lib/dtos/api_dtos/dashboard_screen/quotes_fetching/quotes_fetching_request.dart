class QuotesFetchingRequest {
  String apikey;
  int pageNo;
  int pageSize;
  String sortBy;
  String orderBy;
  String userid;
  List<int?> readedList;
  

  QuotesFetchingRequest(
      {
      required this.apikey,  
      required this.pageNo,
      required this.pageSize,
      required this.sortBy,
      required this.orderBy,
      required this.userid,
      required this.readedList
      
      });

    Map<String, String> toHeaders() {
    return {'Content-Type': 'application/json', 'apikey': apikey};
  }
    

  Map<String, String> toMap() {
    return {
      'pageNo': '${pageNo.toString()}',
      'pageSize': '${pageSize.toString()}',
      'sortBy': '${sortBy.toString()}',
      'orderBy': '${orderBy.toString()}',
      'userid':'${userid.toString()}'
    };
  }

  Map<String, dynamic> toBody() {
    return {
      'readedList':readedList
    };
  }
}
