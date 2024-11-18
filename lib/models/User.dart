class User {
  int? id;
  String? name;
  String? contact;
  String? description;

  User({this.name, this.contact, this.description});
  User.withId({this.id, this.name, this.contact, this.description});

  // Convert User to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'contact': contact,
      'description': description,
    };
  }

  // Convert Map to User
  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    contact = map['contact'];
    description = map['description'];
  }
}
