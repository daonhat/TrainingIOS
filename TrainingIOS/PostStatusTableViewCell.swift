//
//  PostStatusTableViewCell.swift
//  TrainingIOS
//
//  Created by mod bibi on 7/28/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import UIKit

protocol PostCellDelegate: class{
    func didTapPost()
}

class PostStatusTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var txtPost: UITextField!
    
    weak var delegate: PostCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.txtPost.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.delegate?.didTapPost()
        return true
    }
    
}
