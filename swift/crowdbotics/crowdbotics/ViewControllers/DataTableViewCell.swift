//
//  DataTableViewCell.swift
//  PageDemoi
//
//  Created by Amit Kumar on 19/01/19.
//  Copyright © 2019 Amit Kumar. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastPrice: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var higherPrice: UILabel!
    @IBOutlet weak var lowerPrice: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
