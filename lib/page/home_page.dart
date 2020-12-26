import 'package:antarakata/bloc/post_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:antarakata/model/post.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    postBloc.getKategori();
    postBloc.getLatest();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 42, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Antara Kata", 
              style: TextStyle(
                color: Colors.black, 
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
            ),
            _inputSearch,
            Padding(
              padding: EdgeInsets.only(top: 16),
            ),
            _viewListKategory(),
            Padding(
              padding: EdgeInsets.only(top: 16),
            ),
            Text(
              "Latest", 
              style: TextStyle(
                color: Colors.black, 
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
            ),
            _listPostItem()
          ],
        ),
      ),
    );
  }

  get _inputSearch => Container(
        child: TextField(
          cursorColor: Colors.black,
          autofocus: false,
          maxLines: 1,
          onEditingComplete: () {
            postBloc.submitSearch();
            
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            Navigator.pushNamed(context, '/result-search');
          },
          onChanged: (text) => postBloc.changeSearch(text),
          decoration: InputDecoration(
            hoverColor: Colors.black,
            contentPadding: EdgeInsets.only(top: 2),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            hintText: 'judul post',
            filled: true,
            focusColor: Colors.black,
            fillColor: Colors.grey[300],
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
                borderSide: BorderSide(color: Colors.white, width: 2),
                gapPadding: 2),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(14.0),
                ),
                borderSide: BorderSide(color: Colors.white),
                gapPadding: 2),
          ),
        ),
      );

  //untuk menampilkan data kategori 
  _viewListKategory() => StreamBuilder(
    stream: postBloc.kategori,
    builder: (context, AsyncSnapshot<List<Kategori>> snapshot){
      if(snapshot.hasData){
        return Container(
          height: 38,
          child: ListView.builder(
            itemCount: snapshot.data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: (){
                postBloc.setIdKategoriSelected(snapshot.data[index].id);
                postBloc.setNamaKategori(snapshot.data[index].nama);
                Navigator.pushNamed(context, '/result-kategori');
              },
                child: Container(
                height: 30,
                padding: EdgeInsets.only(top: 10,left: 16, right: 16),
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Text(
                  snapshot.data[index].nama,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            )
          )
        );
      }else{
        return Container(
        );
      }
    }
  );
  //untuk menampilkan per item dari kategori
  _listPostItem() => StreamBuilder(
    stream: postBloc.latest,
    builder: (context, AsyncSnapshot<List<Post>> snapshot){
      if(snapshot.hasData){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for(int i =0; i< snapshot.data.length; i++)
              _itemPost(snapshot.data[i]),
          ],
        );
        
      }else{
        return Container();
      }
    }
  );

  _itemPost(data) => GestureDetector(
    onTap: (){
      postBloc.setSelectedIdPost(""+data.id);
      Navigator.pushNamed(context, '/detail');
    },
    child: Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: "https://antarakata01.000webhostapp.com/asset/img/blog/"+data.image,
              height: 150,
            ),
          ),
          ListTile(
            leading: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.black
              ),
              child: Center(
                child: Icon(
                  Icons.whatshot,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            title: Text(data.judul),
            subtitle: Text(data.isiPost.substring(0,100)),
          )
        ],
      ),
    ),
  );
}