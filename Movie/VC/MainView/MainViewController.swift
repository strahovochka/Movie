import UIKit

class MainViewController: UIViewController {

    private var movies: [Movies.Movie] = Movies().movies
    private var sorting: SortingManager = NameSort()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        configTable()
        configSortButton()
    }
    
    private func configTable() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        
        sorting.sort(movies: &movies)
    }
    
    private func configSortButton() {
        let action = { (action: UIAction) in
            switch action.title {
            case "Name":
                self.sorting = NameSort()
            case "Date":
                self.sorting = DateSort()
            default:
                break
            }
            
            self.sortButton.setImage(action.image, for: .normal)
            self.sortButton.setTitle(action.title, for: .normal)
            self.sorting.sort(movies: &self.movies)
            self.tableView.reloadData()
        }
        
        sortButton.menu = UIMenu(children: [UIAction(title: "Name", image: UIImage(systemName: "textformat.size"), handler: action), UIAction(title: "Date", image: UIImage(systemName: "calendar"), handler: action)])
        
        sortButton.showsMenuAsPrimaryAction = true
        sortButton.changesSelectionAsPrimaryAction = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieVC = segue.destination as? MovieViewController {
            if let row = tableView.indexPathForSelectedRow?.row {
                let movie = movies[row]
                movieVC.movie = movie
            }
        }
    }


}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMovieVC", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
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

