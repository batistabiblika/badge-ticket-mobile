class Badge {
  // fitambaran'ny badge sy ny member ho verification hoe misy ve ilay badge sa tsia
  final String number;
  final String firstname;
  final String lastname;
  final String name;
  final String image;
  final String churchName;
  const Badge(
      {required this.number,
      required this.firstname,
      required this.lastname,
      required this.name,
      required this.image,
      required this.churchName});

  factory Badge.fromJson(Map<String, dynamic> json) {
    return Badge(
      number: json['number'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      name: json['name'],
      image: json['image'],
      churchName: json['churchName'],
    );
  }
}
