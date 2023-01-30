class MyUser{
  static const colectionName = 'user';

  String id;
  String firstName;
  String lastName;
  String email;

  MyUser({required this.id,required this.firstName,required this.lastName,required this.email});

  MyUser.fromJson(Map<String,dynamic>json):this(
    id: json['id'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    email: json['email'] as String
  );
  Map<String,dynamic>toJson(){
    return{
      'id':id,
      'firstName':firstName,
      'lastName':lastName,
      'email':email
    };
  }
}