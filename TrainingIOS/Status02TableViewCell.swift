//
//  Status02TableViewCell.swift
//  TrainingIOS
//
//  Created by mod bibi on 7/28/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import UIKit

class Status02TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblUserName02: UILabel!
    @IBOutlet weak var imgAva02: UIImageView!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblLikes: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    
    var delegate:StatusCellDelegate?
    var indexPath:IndexPath!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttomCommentTouchUpInside(_ sender: Any) {
        delegate?.didTapCmt(in: indexPath)
    }
    
    
}
