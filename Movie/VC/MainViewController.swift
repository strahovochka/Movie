import UIKit

class MainViewController: UIViewController {

    private var movies: [Movies.Movie] = Movies().movies
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }


}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = movies[indexPath.row]
        
        cell.poster.downloadImageWith(link: movie.posterLink)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: movie.releaseDate) else { return UITableViewCell() }
        dateFormatter.dateFormat = "yyyy"
        
        cell.title.text = movie.title + "(\(dateFormatter.string(from: date)))"
        cell.durationAndGenre.text = "\(movie.duration) - \(movie.genres)"
        return cell
    }
    
    
}

extension UIImageView {
    func downloadImageWith(link: String) {
        URLSession.shared.dataTask(with: URL(string: link)!) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else { return }
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}

