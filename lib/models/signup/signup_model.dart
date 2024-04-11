class SignUpModel {
    String userId;
    String firstName;
    String lastName;
    String email;
    String role;
    String apikey;
    String? paymentEndDate;

    SignUpModel({
        required this.userId,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.role,
        required this.apikey,
        this.paymentEndDate
    });

    factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        role: json["role"],
        apikey: json["apikey"],
        paymentEndDate: json["payment_end_date"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "role": role,
        "apikey": apikey,
        "payment_end_date":paymentEndDate
    };
}
