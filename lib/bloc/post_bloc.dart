
import 'package:antarakata/model/post.dart';
import 'package:antarakata/repository/post_repository.dart';
import 'package:rxdart/rxdart.dart';

class PostBloc{
  PostRepository _repository = PostRepository();
  final _kategori = BehaviorSubject<List<Kategori>>();
  final _latest = BehaviorSubject<List<Post>>();
  final _idPostSelected = BehaviorSubject<String>();
  final _idKategoriSelected = BehaviorSubject<String>();
  final _kategoriSelected = BehaviorSubject<List<Post>>();
  final _postSelected = BehaviorSubject<Post>();
  final _namaKategori = BehaviorSubject<String>();
  final _search = BehaviorSubject<String>();
  final _searchRes = BehaviorSubject<List<Post>>();

  getKategori()async{
    List<Kategori> res = await _repository.kategori();
    _kategori.sink.add(res);
    print(kategoriToJson(res));
  }
  setSelectedIdPost(String id) {
    _idPostSelected.sink.add(id);
  }

  setIdKategoriSelected(String id){
    _idKategoriSelected.sink.add(id);
  }

  getPostFromKategori() async{
    List<Post> res = await _repository.postByKategori(_idKategoriSelected.value);
    //print(postToJson(res));
    _kategoriSelected.sink.add(res);
  }

  getDetailPost() async{
    Post res = await _repository.detailPost(_idPostSelected.value);
    print(postSingleToJson(res));
    _postSelected.sink.add(res);
  }

  getLatest() async{
    List<Post> res = await _repository.latest();
    //print(postToJson(res));
    _latest.sink.add(res);
  }
  setNamaKategori(String nama){
    _namaKategori.sink.add(nama);
    print(_namaKategori.value);
  }

  changeSearch(String search){
    _search.sink.add(search);
  }
  submitSearch()async{
    List<Post> res = await _repository.search(_search.value);
    _searchRes.sink.add(res);
  }

  dispose(){
    _kategori.close();
    _latest.close();
    _idPostSelected.close();
    _postSelected.close();
    _idKategoriSelected.close();
    _kategoriSelected.close();
    _namaKategori.close();
    _search.close();
    _searchRes.close();

  }
  BehaviorSubject<List<Kategori>> get kategori => _kategori.stream;
  BehaviorSubject<List<Post>> get latest => _latest.stream;
  BehaviorSubject<String> get idPostSelected => _idPostSelected.stream;
  BehaviorSubject<Post> get postSelected => _postSelected.stream;
  BehaviorSubject<String> get idKategoriSelected => _idKategoriSelected.stream;
  BehaviorSubject<List<Post>> get kategoriSelected => _kategoriSelected.stream;
  BehaviorSubject<String> get namaKategori => _namaKategori.stream;
  BehaviorSubject<List<Post>> get searchResult => _searchRes.stream;
  BehaviorSubject<String> get search => _search.stream;
}

final postBloc = PostBloc();