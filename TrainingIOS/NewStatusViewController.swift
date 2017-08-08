//
//  NewStatusViewController.swift
//  TrainingIOS
//
//  Created by DaoNhat on 8/4/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import UIKit

class NewStatusViewController: UIViewController {

    @IBOutlet weak var txtContent_Status: UITextField!
    var status:Status?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveStatus" {
            self.status = Status.init(userName: "Dao Nhat", content: self.txtContent_Status.text, avatar: #imageLiteral(resourceName: "ic_ava_1"), type: 2, image: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
