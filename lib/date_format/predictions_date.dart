class PredictionsDate {

  List predictions;
  String description ;
  String place_id ;
  String reference ;
  String main_text ;
  String secondary_text ;
  List terms ;
  String types ;
  String point_of_interest ;
  String establishment ;
  List structured_formatting ;

  String status;


  PredictionsDate(
 this.predictions,
  this.description,
  this.place_id,
      this.reference,
    this.main_text, this.secondary_text,
      this.terms,
      this.types,
    this.point_of_interest,
      this.establishment,
      this.structured_formatting, this.status
    );




  PredictionsDate.fromMap(Map<String,dynamic>map){
    this.predictions=map['predictions'] ;
   this.description=map['description'] ;
    this.place_id=map['place_id'] ;
    this.reference=map['reference'] ;
    this.main_text=map['structured_formatting']['main_text'] ;
    this.secondary_text=map['structured_formatting']['secondary_text'] ;
    this.point_of_interest=map['types'][0] ;
    this.establishment=map['types'][1] ;
    this.terms=map['terms'];
  //  this.structured_formatting=map['structured_formatting'];
   // this.status=map['status'];

  }
}