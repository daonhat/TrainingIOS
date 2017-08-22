//
//  Status01TableViewCell.swift
//  TrainingIOS
//
//  Created by mod bibi on 7/27/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import UIKit

protocol StatusCellDelegate {
    func didTapCmt(in indexPath: IndexPath!)
}

class Status01TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgAva01: UIImageView!
    @IBOutlet weak var lblStatus01: UILabel!
    @IBOutlet weak var lblUserName01: UILabel!
    @IBOutlet weak var imgImage: UIImageView!
    var indexPath:IndexPath!
    
    
    var delegate: StatusCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func cmtBtnClicked(_ sender: Any) {
            delegate?.didTapCmt(in: self.indexPath)
    }
    
    
}
