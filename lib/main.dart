import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:intl/intl.dart';
import 'package:news_app/model/artical_model.dart';
import 'package:news_app/pages/article_details_page.dart';
import 'package:news_app/services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiService client = ApiService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF464646),
      appBar: AppBar(
        title: Center(
          child: Text("HEADLINES",
              style: GoogleFonts.robotoSlab(
                  fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        backgroundColor: const Color(0xFF000000),
      ),
      body: FutureBuilder<ArticalModel>(
        future: client.getArticle(),
        builder: (BuildContext context, AsyncSnapshot<ArticalModel> snapshot) {
          //print("connection State ${snapshot.connectionState.name}");

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            //print("snapshot.hasData ${snapshot.hasData}");
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.articles![index];
                    var date = DateTime.parse(data.publishedAt!);
                    var formattedDate =
                        "${date.year}-${date.month}-${date.day}";
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context)=>
                            ArticlePage(
                              data: data,
                            )));
                      },
                      child: Stack(
                        children: [
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
                              height: MediaQuery.of(context).size.height * 0.32,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      data.urlToImage!,
                                    ),
                                    fit: BoxFit.cover,
                                  colorFilter:
                                  ColorFilter.mode(Colors.black.withOpacity(0.6),
                                      BlendMode.dstATop),),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 50,
                            left: 30,
                            right: 30,
                            child: Text(data.title!,
                                style: GoogleFonts.robotoSlab(
                                    color: Colors.white, fontSize: 20)),
                          ),
                          Positioned(
                              bottom: 20,
                              left: 30,
                              child: Row(
                                children: [
                                  Text(
                                    data.source!.name!,
                                    style: GoogleFonts.robotoSlab(
                                      color: Colors.white38,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    formattedDate,
                                    style: GoogleFonts.robotoMono(
                                        color: Colors.white38, fontSize: 15),
                                  )
                                ],
                              )),
                        ],
                      ),
                    );
                  });
            }

            return const Center(
              child: Text('nhi hua'),
            );
          }

          if (snapshot.hasData) {
            return const Center(
              child: Text("Success"),
            );
          }

          return const Center(
            child: Text(''),
          );
        },
      ),
    );
  }
}
