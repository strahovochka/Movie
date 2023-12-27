//
//  MovieTableViewCell.swift
//  Movie
//
//  Created by Jane Strashok on 27.12.2023.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var durationAndGenre: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var poster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
