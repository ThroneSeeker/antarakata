import 'package:antarakata/utils/api_provider.dart';
import 'package:antarakata/model/post.dart';

class PostRepository{
  ApiProvider _apiProvider = ApiProvider();
  Future<List<Kategori>> kategori() => _apiProvider.kategori();
  Future<List<Post>> latest() => _apiProvider.latest();
  Future<List<Post>> postByKategori(String id) => _apiProvider.postByKategori(id);
  Future<List<Post>> search(String q) => _apiProvider.search(q);
  Future<Post> detailPost(String id) => _apiProvider.detailPost(id);
  
}