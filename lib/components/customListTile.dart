import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/model/artical_model.dart';
import 'package:news_app/pages/article_details_page.dart';

Widget customListTile(Articles article, BuildContext context) {
  var index;
  var snapshot;
  var data = snapshot.data!.articles![index];
  var date = DateTime.parse(data.publishedAt!);
  var formattedDate =
      "${date.year}-${date.month}-${date.day}";
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticlePage(
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
                  width: 5,
                ),
                Text(
                  formattedDate,
                  style: GoogleFonts.robotoMono(
                      color: Colors.white38, fontSize: 15),
                )
              ],
            )),
      ],
    )
  );
}