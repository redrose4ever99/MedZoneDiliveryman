// ignore: file_names
// ignore_for_file: public_member_api_docs, sort_constructors_first
class DeliveryMan {
  int? id;
  String? name;
  String? mobile;
  String? code;
  String? notes;

  DeliveryMan();

  //DeliveryMan(this.id, this.name, this.code, this.mobile,this.notes);
  DeliveryMan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    mobile = json['mobile'];
    notes = json['notes'];
  }
}
