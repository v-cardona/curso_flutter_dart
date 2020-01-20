


class Peliculas {

  List<Pelicula> items = new List();

  Peliculas();

  Peliculas.fromJsonList( List<dynamic> jsonList) {

    if (jsonList == null) {
      return;
    }

    for (var item in jsonList) {
      final pelicula = new Pelicula.fromJssonMap(item);
      items.add(pelicula);
    }

  }

}


class Pelicula {
  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<Genre> genres;
  bool adult;
  String backdropPath;
  String overview;
  String releaseDate;

  Pelicula({
    this.adult,
    this.backdropPath,
    this.genres,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Pelicula.fromJssonMap(Map<String, dynamic> json) {
    adult            = json['adult'];
    backdropPath     = json['backdrop_path'];
    genres           = json['genres'];
    id               = json['id'];
    originalLanguage = json['original_language'];
    originalTitle    = json['original_title'];
    overview         = json['overview'];
    popularity       = json['popularity'] / 1.0;
    posterPath       = json['poster_path'];
    releaseDate      = json['release_date'];
    title            = json['title'];
    video            = json['video'];
    voteAverage      = json['vote_average'] / 1.0;
    voteCount        = json['vote_count'];

  }

  getPosterImg() {
    if (posterPath == null) {
      return 'https://securet9.classistatic.com/assets/images/en_ZA/no-image-dc0d8afd5a.svg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

}

class BelongsToCollection {
  int id;
  String name;
  String posterPath;
  String backdropPath;

  BelongsToCollection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  });
}

class Genre {
  int id;
  String name;

  Genre({
    this.id,
    this.name,
  });
}

class ProductionCompany {
  int id;
  String logoPath;
  String name;
  String originCountry;

  ProductionCompany({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });
}

class ProductionCountry {
  String iso31661;
  String name;

  ProductionCountry({
    this.iso31661,
    this.name,
  });
}

class SpokenLanguage {
  String iso6391;
  String name;

  SpokenLanguage({
    this.iso6391,
    this.name,
  });
}
