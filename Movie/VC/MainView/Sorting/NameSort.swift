import Foundation

class NameSort: SortingManager {
    func sort(movies: inout [Movies.Movie]) {
        movies.sort { $0.title < $1.title }
    }
}
