
import 'package:dio/dio.dart';
import 'logging_interceptor.dart';
import 'package:antarakata/model/post.dart';
class ApiProvider{
  Dio get dio => _dio();
  Dio _dio() {
    var options = BaseOptions(
        headers: {'accept': 'application/json'},
        baseUrl: 'https://antarakata01.000webhostapp.com/api/',
        contentType: 'application/json;chaset=utf-8');

    var dio = Dio(options);
    return dio;
  }

  Future<Post> detailPost(String id) async{
    try{
      Response<String> response = await dio.get('post_detail.php?id_post='+id);
      return postSingleFromJson(response.data);
    }on DioError catch(e){
      return null;
    }
  }

  Future<List<Kategori>> kategori()async{
    try{
      Response<String> response = await dio.get('list_kategori.php');
      return kategoriFromJson(response.data);
    }on DioError catch(e){
      return null;
    }
  }

  Future<List<Post>> latest()async{
    try{
      Response<String> response = await dio.get('latest.php');
      return postFromJson(response.data);
    }on DioError catch(e){
      return null;
    }
  }

  Future<List<Post>> search(String q)async{
    try{
      Response<String> response = await dio.get('search.php?q='+q);
      return postFromJson(response.data);
    }on DioError catch(e){
      return null;
    }
  }

  Future<List<Post>> postByKategori(String id)async{
    try{
      Response<String> response = await dio.get('post_by_kategory.php?id_kategori='+id);
      return postFromJson(response.data);
    }on DioError catch(e){
      return null;
    }
  }

}