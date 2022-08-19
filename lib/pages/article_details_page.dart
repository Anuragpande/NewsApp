import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/main.dart';
import 'package:news_app/model/artical_model.dart';
import 'package:flutter/material.dart';
import 'package:news_app/services/api_service.dart';
import 'dart:io';
class ArticlePage extends StatelessWidget {

  Articles data;



   ArticlePage({Key? key,required this.data }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var date = DateTime.parse(data.publishedAt!);
    var formattedDate =
        "${date.year}-${date.month}-${date.day}";
    return Scaffold(
      body: Stack(
        children:[
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [
                    Colors.black,
                    Colors.black,
                    Colors.white
                  ]).createShader(bounds);
            },
            child: Container(
              decoration: BoxDecoration(

                image: DecorationImage(
                  image: NetworkImage(
                    data.urlToImage!,

                  ),
                 // onError:(error, stackTrace) => const NetworkImage('https://eyeclinicofedmonds.com/wp-content/uploads/2017/10/placeholder-image.png'),
                  fit: BoxFit.fill,
                  colorFilter:
                  ColorFilter.mode(Colors.black.withOpacity(0.4),
                      BlendMode.darken),),
              ),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height*0.48,
              right: 20,
              left: 20,
              child: Text(data.title!,
              style:GoogleFonts.openSans(color: Colors.white,
              fontSize: 26,fontWeight: FontWeight.bold),
              )
          ),

          Positioned(
            top: MediaQuery.of(context).size.height*0.78,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                  data.source!.name!.toUpperCase(),
                  style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  ),
                  ),
                  Text(
                    formattedDate,
                    style: GoogleFonts.roboto(
                        color: Colors.white, fontSize: 20),
                  )
                ]

              )
          ),
          Positioned(
              top: MediaQuery.of(context).size.height*0.83,
              left: 20,
              right: 20,
              child: Text(
            data.description!,style:
            GoogleFonts.robotoSlab(color: Colors.white38,
            fontSize:15),
          )),
          Positioned(
    top: MediaQuery.of(context).size.height*0.05,
              left: 20,
              child: Container(

            height: 50,
            width: 50,
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.4),
            ),
            child:  InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>
                       const MyHomePage()));
              },
              child: const Icon(
                Icons.arrow_back,color: Colors.white,size: 30,
              ),
            ),
          ))
        ]
      ),
    );
  }
}

