import 'package:antarakata/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:antarakata/model/post.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    
    postBloc.getDetailPost();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 32, left: 16, right: 16),
        child: StreamBuilder(
          stream: postBloc.postSelected,
          builder: (context,AsyncSnapshot<Post> snapshot){
            if(snapshot.hasData){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      snapshot.data.judul, 
                      style: TextStyle(
                        color: Colors.black, 
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8),),
                    ListTile(
                      leading: Container(
                        height: 48,
                        width: 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
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
                      title: Text('Oleh : '+snapshot.data.penulis.nama),
                      subtitle: Text('Pada : '+snapshot.data.tglInsert.toIso8601String())
                    ),
                    Padding(padding: EdgeInsets.only(top:8),),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: "https://antarakata01.000webhostapp.com/asset/img/blog/"+snapshot.data.image,
                        height: 250,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8),),
                    Text(snapshot.data.isiPost),
                    Padding(padding: EdgeInsets.only(top:16),),
                    Text(
                      "Komentar", 
                      style: TextStyle(
                        color: Colors.black, 
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8),),
                    for(int i =0; i < snapshot.data.komentar.length; i++)
                      Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: ListTile(
                          title: Text(snapshot.data.komentar[i].nama),
                          subtitle: Text(snapshot.data.komentar[i].isi),
                        ),
                      )
                  ],
                );
            }else{
              return Container();
            }
          },
        )
    )
    );
  }
}