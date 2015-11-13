//
//  PlaceCell.swift
//  Places Of interest
//
//  Created by Trainer on 12/11/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {
    
    // outlets
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeDate: UILabel!
    @IBOutlet weak var placeImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
