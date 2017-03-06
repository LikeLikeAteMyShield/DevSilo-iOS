//
//  OtherSearchResultTableViewCell.swift
//  DevSilo
//
//  Created by Jonny Cameron on 28/01/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import UIKit

class OtherSearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sourceIcon: UIImageView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
