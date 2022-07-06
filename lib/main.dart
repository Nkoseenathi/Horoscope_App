import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'Horoscope.dart';
import 'Logic.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nkosi',
      home: Nkosina(),
    );
  }
}

class Nkosina extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Nkosi();
  }
}

class Nkosi extends State<Nkosina> {
  TextEditingController dateC = new TextEditingController();
  TextEditingController name = new TextEditingController();
  DateTime _dateTime = DateTime(1900);

  void res() {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (context) {
        //Horoscope page
        return new Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Horoscope'),
            ),
            backgroundColor: Colors.blue.shade300,
            body: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration:BoxDecoration(border: Border.all(color: Colors.blue)) ,

                child:  SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 4),
                        child: Row(
                          children: [Text("Name: "+(name.text), style: TextStyle(fontSize: 25,fontFamily: 'ship',fontWeight:FontWeight.bold))],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 12),
                        child: Row(
                          children: [
                            Text("Age: "+new Logic(dateC.text).age(), style: TextStyle(fontSize: 25,fontFamily: 'ship',fontWeight:FontWeight.bold))
                          ],
                        ),
                      ),
                    const Divider(height: 20,thickness: 5,),
                      Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Stack(
                                children:<Widget>[ Text("Your zodiac sign is " +
                                    new Logic(dateC.text).starSign() +
                                    "!!!",
                                style: TextStyle(
                                  fontSize: 18,
                                    foreground: Paint()
                                      ..style= PaintingStyle.stroke
                                      ..strokeWidth=6
                                      ..color = Colors.black12,
                                    fontWeight:FontWeight.bold),

                                ),
                                 Text("Your zodiac sign is " +
                                    new Logic(dateC.text).starSign() +
                                              "!!!",style:TextStyle(color: Colors.black54
                                     , fontSize: 18,fontWeight:FontWeight.bold))
                              ]),
                              ),

                            Container(
                              margin: EdgeInsets.only(left: 30,right: 30),
                              width: 500, height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)
                                  ),
                                boxShadow: [
                                  BoxShadow(color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0,3),
                                  )
                                ]
                              ),
                                child: Image.asset(
                              'images/'+new Logic(dateC.text).starSign().toLowerCase()+'.jpg',
                              width: 500, height: 200,

                            )

                            ),

                          ],
                        ),
                      ),
                      const Divider(height: 20,thickness: 5,),
                      Center(
                        child: FutureBuilder<Horoscope>(
                          future: fetchHoroscope(new Logic(dateC.text).starSign()),
                          builder: (context, snapshot) {

                            if (snapshot.hasData) {
                              String text = snapshot.data!.horoscope;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(

                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)
                                      ),
                                      boxShadow: [
                                        BoxShadow(color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,3),
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    //
                                    child: Text(text.replaceAll(new Logic(dateC.text).starSign(), name.text) ,
                                      style:  TextStyle(fontSize: 18,color:Colors.black,
                                          fontFamily: 'playfair',fontWeight:FontWeight.bold,),

                                  ),
                                ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }

                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    ));
  }

  @override
  void initState() {
    dateC.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Details page
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Horoscope'),
      ),
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
                child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage(
                      'images/zodiac.jpg',
                    ))),
            SizedBox(
              height: 10,
            ),
            Container(child: Text('Welcome to the Zodiac sign finder', style: TextStyle(fontSize: 18,
                foreground: Paint()
              ..shader = ui.Gradient.linear(
                  const Offset(0,150),
                  const Offset(30,120),
                  <Color>[
                    Colors.lightBlue,
                    Colors.blueAccent,
                  ]
              ),
                fontWeight:FontWeight.bold
            ),)),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0,left: 8.0),
              child: TextField(
                controller: name,
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter name and surname',
                    icon: Icon(Icons.account_circle)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0,left: 8.0),
              child: TextField(
                obscureText: false,
                controller: dateC,
                //keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Select your date of birth ',
                    icon: Icon(Icons.calendar_today)),
                onTap: () async {
                  //  DateTime date = DateTime(1900);

                  FocusScope.of(context).requestFocus(new FocusNode());

                  DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime(1990),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now()); //.then((date){
                  if (date != null) {
                    String dateF = DateFormat('yyyy-MM-dd').format(date);
                    setState(() {
                      dateC.text = dateF;
                    });
                  } else {
                    print("Date is not selected");
                  }
                  //});

                  //
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                res();
              },
              child: Text("Check"),
            )
          ]),
        ),
      ),
    );

    ;
  }
}
