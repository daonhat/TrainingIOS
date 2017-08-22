//
//  TimeLineTableViewController.swift
//  TrainingIOS
//
//  Created by mod bibi on 7/27/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import UIKit

class TimeLineTableViewController: UITableViewController, StatusCellDelegate {

    var statusesData:[Status] = [
        Status(userName: "Avada Kedavra", content: "Interesting study, another example is Wordpress, even if you just write a few sentences, it (I may most templates) “appears” that you write quite a lot", avatar: #imageLiteral(resourceName: "ic_ava_1"), type: 1, image: #imageLiteral(resourceName: "stt01")),
        Status(userName: "Tammy Olson", content: "Brainstorming over some wireframes for an upcoming app. #‎ux #‎ui #‎design #‎ios #‎apple #‎studio", avatar: #imageLiteral(resourceName: "ic_ava_post"), type: 2, image: nil),
        Status(userName: "Avada Kedavra", content: "Lorem Ipsum er ganske enkelt fyldtekst fra print- og typografiindustrien.", avatar: #imageLiteral(resourceName: "ic_ava_post"), type: 1, image: #imageLiteral(resourceName: "stt01")),
        Status(userName: "Tammy Olson", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", avatar: #imageLiteral(resourceName: "ic_ava_1"), type: 2, image: nil),
        Status(userName: "Avada Kedavra", content: "Interesting study, another example is Wordpress, even if you just write a few sentences, it (I may most templates) “appears” that you write quite a lot", avatar: #imageLiteral(resourceName: "ic_ava_post"), type: 1, image: #imageLiteral(resourceName: "stt01")),
        
        ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: "PostStatusTableViewCell", bundle: nil), forCellReuseIdentifier: "PostStatus")
        self.tableView.register(UINib(nibName: "Status01TableViewCell", bundle: nil), forCellReuseIdentifier: "Status01")
        self.tableView.register(UINib(nibName: "Status02TableViewCell", bundle: nil), forCellReuseIdentifier: "Status02")
        
        self.tableView.estimatedRowHeight = 300
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.newStatus(_:)), name: NSNotification.Name(rawValue: "newStatus"), object: nil)
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    func didTapCmt(in indexPath: IndexPath!) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "CommentViewController") as! CommentViewController
        secondViewController.status = statusesData[indexPath.row - 1]
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }

    func newStatus(_ notification: NSNotification)  {
        if let status = notification.userInfo?["new_status"] as? Status {
            self.statusesData.insert(status, at: 0)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return statusesData.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostStatus", for: indexPath) as! PostStatusTableViewCell
            return cell
        }
        else{
            let i = indexPath.row - 1
            if statusesData[i].type == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "Status01", for: indexPath) as! Status01TableViewCell

                cell.indexPath = indexPath
                cell.lblUserName01.text = statusesData[i].userName!
                cell.imgAva01.image = statusesData[i].avatar
                cell.lblStatus01.text = statusesData[i].content!
                cell.imgImage.image = statusesData[i].image
                cell.delegate = self
                
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "Status02", for: indexPath) as! Status02TableViewCell

                cell.indexPath = indexPath
                cell.imgAva02.image = statusesData[i].avatar
                cell.lblUserName02.text! = statusesData[i].userName!
                cell.lblContent.text! = statusesData[i].content!
                cell.delegate = self

                return cell
            }
        }
    }
    
        
   /*
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 64
        }
        else{
            
            return 600
        }
        
    }*/
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
