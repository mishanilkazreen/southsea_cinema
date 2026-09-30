import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie> getMovies() {
    return const [
      Movie(
        id: "interstellar",
        name: "Interstellar",
        ageRating: "PG-13",
        publishedYear: 2014,
        description: "When Earth becomes uninhabitable in the future, a farmer and ex-NASA pilot, Joseph Cooper, is tasked to pilot a spacecraft, along with a team of researchers, to find a new planet for humans.",
        imagePath: 'assets/images/interstellar.jpg'
      ),
      Movie(
        id: "prison_of_azkaban_hp",
        name: "Harry Potter and the Prisoner of Azkaban",
        ageRating: "PG",
        publishedYear: 1999,
        description: "Harry Potter, Ron and Hermione return to Hogwarts School of Witchcraft and Wizardry for their third year of study, where they delve into the mystery surrounding an escaped prisoner who poses a dangerous threat to the young wizard.",
        imagePath: 'assets/images/prison_of_azkaban_hp.jpg')
    ];
  }
}