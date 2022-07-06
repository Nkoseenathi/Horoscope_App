import 'package:http/http.dart' as http;
import 'dart:convert';
class Logic{

  int mon=0;//month entered by the user
  int date=0;//date entered by the user
  int yb=0;// year of birth
  String dob="";//date of birth

   Logic(String dob){//Constructor
    this.dob = dob;
    var db =dob.split("-");
    this.mon = int.parse(db[1]);
    this.date = int.parse(db[2]);
    this.yb =  int.parse(db[0]);

  }

  Future<http.Response> horo() {

    return http.get(Uri.parse('http://ohmanda.com/api/horoscope/'+starSign().toLowerCase()));
  }
/*
Determines the star sign of the user
 */
String starSign(){


 String star= "Uknown star sign";

 switch(mon){
   case 1:
     star = date<22? "Capricorn":"Aquarius";

     break;

   case 2:
     star = date<21? "Aquarius":"Pisces";
     break;

   case 3:
     star = date<21? "Pisces":"Aries";
     break;

   case 4:
     star = date<22? "Aries":"Taurus";
     break;

   case 5:
     star = date<23? "Taurus":"Gemini";
     break;

   case 6:
     star = date<24? "Gemini":"Canser";
     break;

   case 7:
     star = date<24? "Canser":"Leo";
     break;

   case 8:
     star = date<24? "Leo":"Virgo";
     break;

   case 9:
     star = date<24? "Virgo":"Libra";
     break;

   case 10:
     star = date<24? "Libra":"Scorpio";
     break;


   case 11:
     star = date<24? "Scorpio":"Sagittarius";
     break;


   case 12:
     star = date<23? "Sagittarius":"Capricorn";
     break;

   default:
     star=star;
     break;




 }
 return star;
}

/*
Calculates the age of the user
 */
String age(){
    int ag = (2021-yb);
     return  ag.toString();

}

}