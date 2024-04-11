
class QuoteFetchingModel {
    List<QuoteFetchingModelContent> content;
    int totalPages;
    int totalElements;
    String currentPage;
    String pageSize;

    QuoteFetchingModel({
        required this.content,
        required this.totalPages,
        required this.totalElements,
        required this.currentPage,
        required this.pageSize,
    });

    factory QuoteFetchingModel.fromJson(Map<String, dynamic> json) => QuoteFetchingModel(
        content: List<QuoteFetchingModelContent>.from(json["content"].map((x) => QuoteFetchingModelContent.fromJson(x))),
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        currentPage: json["currentPage"],
        pageSize: json["pageSize"],
    );

    Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "totalPages": totalPages,
        "totalElements": totalElements,
        "currentPage": currentPage,
        "pageSize": pageSize,
    };
}

class QuoteFetchingModelContent {
    String quotesId;
    String quoteDescription;

    QuoteFetchingModelContent({
        required this.quotesId,
        required this.quoteDescription,
    });

    factory QuoteFetchingModelContent.fromJson(Map<String, dynamic> json) => QuoteFetchingModelContent(
        quotesId: json["quotes_id"],
        quoteDescription: json["quote_description"],
    );

    Map<String, dynamic> toJson() => {
        "quotes_id": quotesId,
        "quote_description": quoteDescription,
    };
}