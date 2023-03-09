// To parse this JSON data, do
//
//     final homeCollectionListModel = homeCollectionListModelFromJson(jsonString);

import 'dart:convert';

CollectionListModel homeCollectionListModelFromJson(String str) => CollectionListModel.fromJson(json.decode(str));

String homeCollectionListModelToJson(CollectionListModel data) => json.encode(data.toJson());

class CollectionListModel {
  CollectionListModel({
    this.success,
    this.message,
    this.data,
    this.errors,
    this.code,
  });

  bool? success;
  String? message;
  List<Collections>? data;
  dynamic errors;
  int? code;

  factory CollectionListModel.fromJson(Map<String, dynamic> json) => CollectionListModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Collections>.from(json["data"]!.map((x) => Collections.fromJson(x))),
        errors: json["errors"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "errors": errors,
        "code": code,
      };
}

class Collections {
  Collections({
    this.id,
    this.title,
    this.operationTypeId,
    this.description,
    this.status,
    this.mainProducts,
  });

  int? id;
  String? title;
  int? operationTypeId;
  String? description;
  int? status;
  List<CollectionsMainProduct>? mainProducts;

  factory Collections.fromJson(Map<String, dynamic> json) => Collections(
        id: json["id"],
        title: json["title"],
        operationTypeId: json["operation_type_id"],
        description: json["description"],
        status: json["status"],
        mainProducts: json["main_products"] == null
            ? []
            : List<CollectionsMainProduct>.from(json["main_products"]!.map((x) => CollectionsMainProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "operation_type_id": operationTypeId,
        "description": description,
        "status": status,
        "main_products": mainProducts == null ? [] : List<dynamic>.from(mainProducts!.map((x) => x.toJson())),
      };
}

class CollectionsMainProduct {
  CollectionsMainProduct({
    this.id,
    this.name,
    this.image,
    this.categoryId,
    this.lowestPriceUnitId,
    this.category,
    this.lowestUnit,
  });

  int? id;
  String? name;
  String? image;
  int? categoryId;
  dynamic lowestPriceUnitId;
  Category? category;
  LowestUnit? lowestUnit;

  factory CollectionsMainProduct.fromJson(Map<String, dynamic> json) => CollectionsMainProduct(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      categoryId: json["category_id"],
      lowestPriceUnitId: json["lowest_price_unit_id"],
      category: json["category"] == null ? null : Category.fromJson(json["category"]),
      lowestUnit: json["lowest_unit"] == null ? null : LowestUnit.fromJson(json["lowest_unit"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "category_id": categoryId,
        "lowest_price_unit_id": lowestPriceUnitId,
        "category": category?.toJson(),
        "lowest_unit": lowestUnit,
      };
}

class LowestUnit {
  LowestUnit({
    this.id,
    this.mainProductId,
    this.salePrice,
  });

  int? id;
  int? mainProductId;
  String? salePrice;

  factory LowestUnit.fromJson(Map<String, dynamic> json) => LowestUnit(
        id: json["id"],
        mainProductId: json["main_product_id"],
        salePrice: json["sale_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main_product_id": mainProductId,
        "sale_price": salePrice,
      };
}

class Category {
  Category({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
