//
//  CustomTableViewCell.swift
//  my2projectSnapKitChart
//
//  Created by Home on 21.01.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var totalLosts: UILabel!
    @IBOutlet weak var changeLosts: UILabel!
    @IBOutlet weak var RIPName: UITextView!
    @IBOutlet weak var imageName: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        RIPName.layer.borderColor = CGColor(red: 50, green: 50, blue: 50, alpha: 1)
        RIPName.layer.borderWidth = 0.35
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
