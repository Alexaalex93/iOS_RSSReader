//
//  NewsTableViewCell.swift
//  SimpleRSSReader
//
//  Created by Pablo Mateo Fernández on 02/02/2017.
//  Copyright © 2017 355 Berry Street S.L. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var descriptionLabel:UILabel!
    @IBOutlet weak var dateLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
