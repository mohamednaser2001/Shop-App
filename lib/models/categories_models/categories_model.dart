

class CategoriesModel{
  late bool status;
  late CategoriesDataModel data;

  CategoriesModel.fromJson(Map<String,dynamic>json){
    data = CategoriesDataModel.fromJson(json['data']);
  }

}

class CategoriesDataModel{
  late int currentPage;
  List<DataModel> data=[];

  CategoriesDataModel.fromJson(Map<String,dynamic>json){
    json['data'].forEach((element)=>{
      data.add(DataModel.fromJson(element)),
    });
  }


}

class DataModel{
  late int id;
  late String name ;
  late String image;

  DataModel.fromJson(Map<String ,dynamic>json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}