import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Kategori> kategoriFromJson(String str) => List<Kategori>.from(json.decode(str).map((x) => Kategori.fromJson(x)));

String kategoriToJson(List<Kategori> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Post postSingleFromJson(String str) => Post.fromJson(json.decode(str));

String postSingleToJson(Post data) => json.encode(data.toJson());

class Post {
    Post({
        this.id,
        this.judul,
        this.isiPost,
        this.tglInsert,
        this.tglUpdate,
        this.image,
        this.penulis,
        this.kategori,
        this.komentar,
    });

    String id;
    String judul;
    String isiPost;
    DateTime tglInsert;
    DateTime tglUpdate;
    String image;
    Penulis penulis;
    Kategori kategori;
    List<Komentar> komentar;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        judul: json["judul"],
        isiPost: json["isi_post"],
        tglInsert: DateTime.parse(json["tgl_insert"]),
        tglUpdate: DateTime.parse(json["tgl_update"]),
        image: json["image"],
        penulis: Penulis.fromJson(json["penulis"]),
        kategori: Kategori.fromJson(json["kategori"]),
        komentar: List<Komentar>.from(json["komentar"].map((x) => Komentar.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "isi_post": isiPost,
        "tgl_insert": "${tglInsert.year.toString().padLeft(4, '0')}-${tglInsert.month.toString().padLeft(2, '0')}-${tglInsert.day.toString().padLeft(2, '0')}",
        "tgl_update": "${tglUpdate.year.toString().padLeft(4, '0')}-${tglUpdate.month.toString().padLeft(2, '0')}-${tglUpdate.day.toString().padLeft(2, '0')}",
        "image": image,
        "penulis": penulis.toJson(),
        "kategori": kategori.toJson(),
        "komentar": List<dynamic>.from(komentar.map((x) => x.toJson())),
    };
}

class Kategori {
    Kategori({
        this.id,
        this.nama,
    });

    String id;
    String nama;

    factory Kategori.fromJson(Map<String, dynamic> json) => Kategori(
        id: json["id"],
        nama: json["nama"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
    };
}

class Komentar {
    Komentar({
        this.id,
        this.isi,
        this.nama,
        this.tglUpdate,
    });

    String id;
    String isi;
    String nama;
    DateTime tglUpdate;

    factory Komentar.fromJson(Map<String, dynamic> json) => Komentar(
        id: json["id"],
        isi: json["isi"],
        nama: json["nama"],
        tglUpdate: DateTime.parse(json["tgl_update"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "isi": isi,
        "nama": nama,
        "tgl_update": "${tglUpdate.year.toString().padLeft(4, '0')}-${tglUpdate.month.toString().padLeft(2, '0')}-${tglUpdate.day.toString().padLeft(2, '0')}",
    };
}

class Penulis {
    Penulis({
        this.id,
        this.nama,
        this.email,
        this.alamat,
    });

    String id;
    String nama;
    String email;
    String alamat;

    factory Penulis.fromJson(Map<String, dynamic> json) => Penulis(
        id: json["id"],
        nama: json["nama"],
        email: json["email"],
        alamat: json["alamat"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "email": email,
        "alamat": alamat,
    };
}