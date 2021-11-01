class Owner {
  final String? name;
  final String? face;
  final int? fans;

  Owner({this.name, this.face, this.fans});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      name: json['name'],
      face: json['face'],
      fans: json['fans'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "name": name,
      "face": face,
      "fans": fans,
    };
  }
}
