class SendResetTokenModel {
    String id;
    String userId;
    String token;
    String expiryAt;
    String apikey;

    SendResetTokenModel({
        required this.id,
        required this.userId,
        required this.token,
        required this.expiryAt,
        required this.apikey,
    });

    factory SendResetTokenModel.fromJson(Map<String, dynamic> json) => SendResetTokenModel(
        id: json["id"],
        userId: json["user_id"],
        token: json["token"],
        expiryAt: json["expiry_at"],
        apikey: json["apikey"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "token": token,
        "expiry_at": expiryAt,
        "apikey": apikey,
    };
}