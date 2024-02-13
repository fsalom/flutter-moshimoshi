class Token {
  String value = "";
  int timestampExpires = 0;

  Token();

  Token.fromJson(Map<String, dynamic> json)
      : value = json['value'],
        timestampExpires = json['timestampExpires'];

  Map<String, dynamic> toJson() => {
        'value': value,
        'timestampExpires': timestampExpires,
      };
  
}