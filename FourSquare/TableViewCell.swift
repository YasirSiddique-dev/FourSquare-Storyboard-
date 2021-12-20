//
//  TableViewCell.swift
//  FourSquare
//
//  Created by Yasir  on 11/26/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeProduct: UILabel!
    @IBOutlet weak var placeDistance: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
