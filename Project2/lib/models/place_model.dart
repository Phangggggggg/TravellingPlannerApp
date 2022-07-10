class PlaceModel {
  String? placeId;
  String? placeName;
  double? latitude;
  double? longitude;
  String? shaTypeDescription;
  String? introduction;
  String? detial;
  String? address;
  String? subDistrict;
  String? district;
  String? province;
  String? postcode;
  String? phones;
  String? picUrl;

  PlaceModel(
      {required this.placeId,
      this.placeName,
      this.latitude,
      this.longitude,
      this.shaTypeDescription,
      this.introduction,
      this.detial,
      this.address,
      this.subDistrict,
      this.district,
      this.province,
      this.postcode,
      this.phones,
      this.picUrl});
  static PlaceModel fromJson(json) {
    String numbers = "";
    var phoneJson = json["contact"]["phones"];
    if (phoneJson != null) {
      numbers = phoneJson[0].toString();
    }

    PlaceModel placeModel = new PlaceModel(
        placeId: json['place_id'],
        placeName: json["place_name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        shaTypeDescription: json["sha"]["sha_type_description"],
        introduction: json["place_information"]['introduction'],
        detial: json["place_information"]['detail'],
        address: json["location"]["address"],
        subDistrict: json["location"]["sub_district"],
        district: json["location"]["district"],
        province: json["location"]["province"],
        postcode: json["location"]["postcode"],
        phones: numbers,
        picUrl: json["thumbnail_url"]);
    return placeModel;
  }

  static PlaceModel fromJsonFireBase(json) {
     PlaceModel placeModel = new PlaceModel(
        placeId: json['placeId'],
        placeName: json["placeName"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        shaTypeDescription: json["shaTypeDescription"],
        introduction: json['introduction'],
        detial: json['detial'],
        address: json["address"],
        subDistrict: json["subDistrict"],
        district: json["district"],
        province: json["province"],
        postcode: json["postcode"],
        phones: json['phones'],
        picUrl: json["picUrl"]);
    return placeModel;
  }
}
