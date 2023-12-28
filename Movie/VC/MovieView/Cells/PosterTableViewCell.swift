import UIKit

class PosterTableViewCell: UITableViewCell {

    @IBOutlet weak var watchTrailerButton: UIButton!
    @IBOutlet weak var addToWatchlistButton: UIButton!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    var trailerLink: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    @IBAction func onWatchTrailerTouched(_ sender: Any) {
        if let trailerLink = trailerLink, let url = URL(string: trailerLink) {
            UIApplication.shared.open(url)
        }
    }
}
