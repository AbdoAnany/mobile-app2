class MealsDate {

 
  String type ;
  String img ;
  int plus_price ;
  int regular_price ;
  String name ;
  String restaurant ;





  MealsDate.fromMap(Map<String,dynamic>map){
    this.img=map['img'] ;
    this.plus_price=map['plus_price'] ;
    this.name=map['name'] ;
    this.restaurant=map['restaurant'] ;
    this.regular_price=map['regular_price'] ;

  }
}