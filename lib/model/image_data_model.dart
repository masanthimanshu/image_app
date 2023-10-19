// To parse this JSON data, do
//
//     final imageDataModel = imageDataModelFromJson(jsonString);

import 'dart:convert';

ImageDataModel imageDataModelFromJson(String str) =>
    ImageDataModel.fromJson(json.decode(str));

String imageDataModelToJson(ImageDataModel data) => json.encode(data.toJson());

class ImageDataModel {
  final String status;
  final List<Image> images;

  ImageDataModel({
    required this.status,
    required this.images,
  });

  factory ImageDataModel.fromJson(Map<String, dynamic> json) => ImageDataModel(
        status: json["status"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Image {
  final String xtImage;
  final String id;

  Image({
    required this.xtImage,
    required this.id,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        xtImage: json["xt_image"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "xt_image": xtImage,
        "id": id,
      };
}
