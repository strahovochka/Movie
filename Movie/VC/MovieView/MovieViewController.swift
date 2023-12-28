import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var movie: Movies.Movie? {
        didSet {
            loadPoster()
        }
    }
    var moviePoster: UIImage? {
        didSet{
            configCells()
        }
    }
    var cells: [CellType]? {
        didSet {
            configTable()
        }
    }
    
    enum CellType {
        case poster(poster: UIImage, name: String, rating: Double, trailerLink: String)
        case description(contents: String)
        case details(genre: String, releaseDate: String)
        
        var cellIdn: String {
            switch self {
            case .poster:
                return "PosterTableViewCell"
            case .description:
                return "DescriptionTableViewCell"
            case .details:
                return "DetailsTableViewCell"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func configTable() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "PosterTableViewCell", bundle: nil), forCellReuseIdentifier: "PosterTableViewCell")
        tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        tableView.register(UINib(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailsTableViewCell")
    }
    
    private func configCells() {
        guard let movie = movie, let moviePoster = moviePoster else { return }
        cells = [
            .poster(poster: moviePoster, name: movie.title, rating: movie.rating, trailerLink: movie.trailerLink),
            .description(contents: movie.description),
            .details(genre: movie.genres, releaseDate: movie.releaseDate)
        ]
    }
    
    private func loadPoster() {
        if let movie = movie {
            URLSession.shared.dataTask(with: URL(string: movie.posterLink)!) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    self.moviePoster = UIImage(data: data)
                }
            }.resume()
        }
    }

}

extension MovieViewController: UITableViewDelegate {
    
}

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = cells?[indexPath.row] else { return UITableViewCell() }
        switch cellType {
        case let .poster(poster, name, rating, trailerLink):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdn, for: indexPath) as? PosterTableViewCell else { return UITableViewCell() }
            
            cell.posterImage.image = poster
            
            cell.title.text = name
            
            let boldString: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 17),
                .foregroundColor: UIColor.black
            ]
            let ratingString = NSMutableAttributedString(string: String(rating), attributes: boldString)
            let tenString = NSAttributedString(string: "/10")
            ratingString.append(tenString)
            cell.rating.attributedText = ratingString
            
            cell.watchTrailerButton.layer.borderWidth = 2
            cell.watchTrailerButton.layer.borderColor = UIColor.black.cgColor
            cell.watchTrailerButton.layer.cornerRadius = cell.watchTrailerButton.bounds.size.height / 2.0
            
            return cell
        case let .description(contents):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdn, for: indexPath) as? DescriptionTableViewCell else { return UITableViewCell() }
            
            cell.descriptionLabel.text = contents
            return cell
        case let .details(genre, releaseDate):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdn, for: indexPath) as? DetailsTableViewCell else { return UITableViewCell() }
            
            cell.genre.text = genre
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            guard let date = dateFormatter.date(from: releaseDate) else { return UITableViewCell() }
            dateFormatter.dateFormat = "yyyy, d MMM"
            dateFormatter.locale = Locale(identifier: "en")
            cell.releaseDate.text = dateFormatter.string(from: date)
            return cell
        }
    }
    
    
}
