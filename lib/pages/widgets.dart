import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget infoWeather(IconData icone, String measured, String value){
  return Padding(
    padding: const EdgeInsets.only(bottom:12.0),
    child: Container(
                        height: 130,
                        width: 180,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(28),
                          
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                children: [Icon(icone,color: Colors.white,size: 40,)],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("$measured",style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            ),Padding(
                              padding: const EdgeInsets.only(top:4.0,left: 10),
                              child: Row(
                                children: [
                                  Text("$value",style: TextStyle(color: Colors.white))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
  );
}

Widget forecast(String hour, String animation,String weather,String precipataions){
  return  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Text(hour+":00",style: TextStyle(
          color: Colors.white,
          fontSize: 20
        ),),
        Lottie.asset(animation,height: 65,width: 65),
        Text(weather,
      style: TextStyle(fontSize: 20,color: Colors.white),),
      Row(
        children: [
          Icon(CupertinoIcons.drop,color: Colors.white,size: 16,),
          Text(precipataions,style: TextStyle(fontSize: 16,color: Colors.white),)
        ],
      )
      ],
    ),
  );
}

class forecastt extends StatefulWidget {
  final String? hour;
  final String? animation;
  final String? weather;
  final String? precipataions;
  
  const forecastt({this.hour,this.animation,this.weather,this.precipataions});
  
  @override
  State<forecastt> createState() => _forecasttState();
}

class _forecasttState extends State<forecastt> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onDoubleTap: () {
        setState(() {
          isTapped = !isTapped;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isTapped? Colors.white.withOpacity(0.3):Colors.transparent,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          children: [
            Text(widget.hour! +":00",style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),),
            Lottie.asset(widget.animation!,height: 65,width: 65),
            Text(widget.weather!,
          style: TextStyle(fontSize: 20,color: Colors.white),),
          Row(
            children: [
              Icon(CupertinoIcons.drop,color: Colors.white,size: 16,),
              Text(widget.precipataions!,style: TextStyle(fontSize: 16,color: Colors.white),)
            ],
          )
          ],
        ),
      ),
    ),
  );
  }
}