import Foundation

struct Movies {
    
    var movies: [Movie] = [Movie(posterLink: "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcT2BXI-jnVvsXmnfiAjcMKFzNRyjmVwbCTeLwYAuAO6MstrqOZ5", title: "Tenet", description: "Armed with only one word, Tenet, and fighting for the survival of the entire world, a Protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real time", rating: 7.8, minutes: 150, genres: "Action, Sci-Fi", releaseDate: "2020-09-03", trailerLink: "https://www.youtube.com/watch?v=LdOM0x0XDMo"), Movie(posterLink:  "https://www.fox28spokane.com/wp-content/uploads/2019/01/Spider-Man_Into_the_Spider-Verse_2018_poster.png" ,title: "Spider-Man: Into the Spider-Verse", description: "Teen Miles Morales becomes the Spider-Man of his universe, and must join with five spider-powered individuals from other dimensions to stop a threat for all realities", rating: 8.4, minutes: 117, genres: "Action, Animation, Adventure", releaseDate: "2018-12-14", trailerLink: "https://www.youtube.com/watch?v=tg52up16eq0"), Movie(posterLink: "https://m.media-amazon.com/images/M/MV5BMGUwZjliMTAtNzAxZi00MWNiLWE2NzgtZGUxMGQxZjhhNDRiXkEyXkFqcGdeQXVyNjU1NzU3MzE@._V1_.jpg", title: "Knives Out", description: "A detective investigates the death of a patriarch of an eccentric, combative family", rating: 7.9, minutes: 130, genres: "Comedy, Crime, Drama", releaseDate: "2019-11-27", trailerLink: "https://www.youtube.com/watch?v=qGqiHJTsRkQ"), Movie(posterLink: "https://m.media-amazon.com/images/M/MV5BNDIzMTk4NDYtMjg5OS00ZGI0LWJhZDYtMzdmZGY1YWU5ZGNkXkEyXkFqcGdeQXVyMTI5NzUyMTIz._V1_.jpg", title: "Guardians of the Galaxy", description: "A group of intergalactic criminals must pull together to stop a fanatical warrior with plans to purge the universe", rating: 8.0, minutes: 121, genres: "Action, Adventure, Comedy", releaseDate: "2014-08-01", trailerLink: "https://www.youtube.com/watch?v=d96cjJhvlMA"), Movie(posterLink: "https://m.media-amazon.com/images/M/MV5BMTM4OGJmNWMtOTM4Ni00NTE3LTg3MDItZmQxYjc4N2JhNmUxXkEyXkFqcGdeQXVyNTgzMDMzMTg@._V1_.jpg", title: "Avengers: Age of Ultron", description: "When Tony Stark and Bruce Banner try to jump-start a dormant peacekeeping program called Ultron, things go horribly wrong and it's up to Earth's mightiest heroes to stop the villainous Ultron from enacting his terrible plan", rating: 7.3, minutes: 141, genres: "Action, Adventure, Sci-Fi", releaseDate: "2015-05-01", trailerLink: "https://www.youtube.com/watch?v=tmeOjFno6Do")]
    
    struct Movie {
        var posterLink: String
        var title: String
        var description: String
        var rating: Double
        var minutes: Int
        var duration: String {
            let hours = Int(minutes/60)
            let mins = minutes - hours*60
            return "\(hours)h \(mins)m"
        }
        var genres: String
        var releaseDate: String
        var trailerLink: String
    }
}


