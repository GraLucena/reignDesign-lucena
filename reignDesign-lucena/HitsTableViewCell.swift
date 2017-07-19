//
//  HitsTableViewCell.swift
//  reignDesign-lucena
//
//  Created by Graciela Lucena on 7/18/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit

class HitsTableViewCell: UITableViewCell {

    //MARK: @IBOutlets
    @IBOutlet var title: UILabel!
    @IBOutlet var hitInfo: UILabel!
    
    //MARK: Initializers
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
