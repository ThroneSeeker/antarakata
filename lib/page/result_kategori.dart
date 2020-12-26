import 'package:flutter/material.dart';
import 'package:antarakata/bloc/post_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:antarakata/model/post.dart';

class ResultKategoriPage extends StatefulWidget {
  @override
  _ResultKategoriPageState createState() => _ResultKategoriPageState();
}

class _ResultKategoriPageState extends State<ResultKategoriPage> {
  @override
  void initState() {
    // TODO: implement initState
    postBloc.getPostFromKategori();
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
            getKategori(),
            Padding(padding: EdgeInsets.only(top:16)),
            _listPostItem()
          ],
        ),
      ),
    );
  }
  getKategori() => StreamBuilder(
    stream: postBloc.namaKategori,
    builder: (context, snapshot){
      if(snapshot.hasData){
        return Text(
              "Kategori "+snapshot.data, 
              style: TextStyle(
                color: Colors.black, 
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            );
      }else{
        return Center(
          child: Text(
            'Data tidak ditemukan.'
          ),
        );
      }
    }
  );

  _listPostItem() => StreamBuilder(
    stream: postBloc.kategoriSelected,
    builder: (context, AsyncSnapshot<List<Post>> snapshot){
      if(snapshot.hasData){
        // return Expanded(
        //   child: ListView.builder(
        //   itemCount: snapshot.data.length,
        //   shrinkWrap: false,
        //   itemBuilder: (context, index) => _itemPost(snapshot.data[index]),
        // ));
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