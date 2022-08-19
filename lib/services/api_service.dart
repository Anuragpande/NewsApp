import 'package:http/http.dart';
import 'dart:convert';

import '../model/artical_model.dart';

class ApiService {

  final endPointUrl =
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=b0c565952d41425282b5f9acc3d200b2";

  Future<ArticalModel> getArticle() async{
    Response res = await get(Uri.parse(endPointUrl));

    print("response ${res.statusCode} ${res.body}");
    if(res.statusCode == 200){
        Map<String, dynamic> json = jsonDecode(res.body);
        ArticalModel articles =  ArticalModel.fromJson(json);

        print("articles $articles");
        return articles;
    }
    else{
      throw('Can\'t get the Articles');
    }
  }
}