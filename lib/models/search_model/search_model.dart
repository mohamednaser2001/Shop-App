





class SearchModel {
  bool? status;
  String? message;
  DataModel? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  DataModel.fromJson(json['data']) : null;
  }
}

class DataModel {
  int? currentPage;
  List<ProductSearchModel>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;


  DataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ProductSearchModel>[];
      json['data'].forEach((v) {
        data!.add(ProductSearchModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

}

class ProductSearchModel {
  late int id;
  late bool inFavorites;
  late bool inCard;
  late dynamic price;
  late String image;
  late String name;
  String? description;


  ProductSearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCard = json['in_cart'];
    description = json['description'];
  }

}