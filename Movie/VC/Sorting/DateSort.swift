import Foundation

class DateSort: SortingManager {
    func sort(movies: inout [Movies.Movie]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        movies.sort { dateFormatter.date(from: $0.releaseDate) ?? Date() > dateFormatter.date(from: $1.releaseDate) ?? Date() }
    }
}
