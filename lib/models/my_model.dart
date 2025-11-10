class MyModel {
  final Data? data;
  final int? status;

  MyModel({this.data, this.status});

  factory MyModel.fromJson(Map<String, dynamic> json) {
    return MyModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'status': status,
    };
  }
}

class Data {
  final List<Item>? items;
  final int? page;
  final int? pageSize;
  final int? totalItems;
  final int? totalPages;
  final int? status;

  Data({
    this.items,
    this.page,
    this.pageSize,
    this.totalItems,
    this.totalPages,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e))
          .toList(),
      page: json['page'],
      pageSize: json['page_size'],
      totalItems: json['total_items'],
      totalPages: json['total_pages'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items?.map((e) => e.toJson()).toList(),
      'page': page,
      'page_size': pageSize,
      'total_items': totalItems,
      'total_pages': totalPages,
      'status': status,
    };
  }
}

class Item {
  final String? id;
  final String? status;
  final String? title;
  final Location? location;
  final String? projectType;
  final String? buildingType;
  final String? projectPrice;
  final String? priceUnit;
  final int? totalUnits;
  final String? unitPrice;
  final List<String>? coverImageUrls;
  final String? publishedAt;
  final int? unitsSold;

  Item({
    this.id,
    this.status,
    this.title,
    this.location,
    this.projectType,
    this.buildingType,
    this.projectPrice,
    this.priceUnit,
    this.totalUnits,
    this.unitPrice,
    this.coverImageUrls,
    this.publishedAt,
    this.unitsSold,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['_id'],
      status: json['status'],
      title: json['title'],
      location:
      json['location'] != null ? Location.fromJson(json['location']) : null,
      projectType: json['projectType'],
      buildingType: json['buildingType'],
      projectPrice: json['projectPrice'],
      priceUnit: json['priceUnit'],
      totalUnits: json['totalUnits'],
      unitPrice: json['unitPrice'],
      coverImageUrls:
      (json['coverImageUrls'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      publishedAt: json['published_at'],
      unitsSold: json['unitsSold'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'status': status,
      'title': title,
      'location': location?.toJson(),
      'projectType': projectType,
      'buildingType': buildingType,
      'projectPrice': projectPrice,
      'priceUnit': priceUnit,
      'totalUnits': totalUnits,
      'unitPrice': unitPrice,
      'coverImageUrls': coverImageUrls,
      'published_at': publishedAt,
      'unitsSold': unitsSold,
    };
  }
}

class Location {
  final String? city;
  final String? country;

  Location({this.city, this.country});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      city: json['city'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'country': country,
    };
  }
}
