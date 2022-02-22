import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';



class MenuPrincipal extends StatefulWidget {
  @override
  State<MenuPrincipal> createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  @override
  Widget build(BuildContext context) {
    Items item1 = new Items(title: "Jugar", 
    img: "assets/images/rompe.png");

    Items item2 = new Items(
      title: "Como se \njuega",
      img: "assets/images/dash.png",
    );
 Items item3 = new Items(
      title: "Redes \nsociales",
      img: "assets/images/dash.png",
    );

    List<Items> myList = [
      item1,
      item2,
      item3,
    ];

    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1.6;

    return 
    Material(
          child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/faons.png'),
              fit: BoxFit.cover,
            )),
          ),
          Container(
            margin: EdgeInsets.only(top: 110),
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Lottie.asset('assets/lottie/brain2.json'),
            ),
          ),
          GridView.count(
              shrinkWrap: true,
              childAspectRatio: (itemWidth / itemHeight),
              padding: const EdgeInsets.only(left: 16, right: 16, top: 120),
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 50,
              children: myList.map((data) {
                return   
             Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.white,
                            Colors.white54,
                          ],
                        ),
                        border: Border.all(color: Colors.blueAccent),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                          //tienen pensado
                        ],
                        borderRadius: BorderRadius.circular(30)                     
                        ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          data.img,
                          width: 120,
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          data.title,
                          style:
                          TextStyle(fontSize: 20 ,   fontFamily: 'Viga-Regular'  ),                  
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 14,
                        ),

                      ],
                    ),
                  );  
              }).toList()),
        ],
      ),
    );
  }
}

class Items {
  String title;
  String img;
  Items({required this.title, required this.img});
}
