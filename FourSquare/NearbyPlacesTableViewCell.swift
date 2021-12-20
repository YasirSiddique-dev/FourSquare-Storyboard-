//
//  NearbyPlacesTableViewCell.swift
//  FourSquare
//
//  Created by Yasir  on 12/4/21.
//

import UIKit

class NearbyPlacesTableViewCell: UITableViewCell {
    //outlets
    @IBOutlet weak var nearbyPlaceImage: UIImageView!
    @IBOutlet weak var nearbyPlaceName: UILabel!
    @IBOutlet weak var nearbyPlaceCategory: UILabel!
    @IBOutlet weak var nearbyPlaceDistance: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
