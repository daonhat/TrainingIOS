//
//  RefreshTableViewCell.swift
//  TrainingIOS
//
//  Created by DaoNhat on 9/1/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import UIKit

class RefreshTableViewCell: UITableViewCell {
    
    @IBOutlet weak var indicatorOfCell: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
    func startStopLoading(_ isStart : Bool)
    {
        if(isStart)
        {
            indicatorOfCell.startAnimating()
            
        }
        else
        {
            indicatorOfCell.stopAnimating()
        }
    }
}

