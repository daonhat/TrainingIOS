//
//  TimeLineTableViewController.swift
//  TrainingIOS
//
//  Created by mod bibi on 7/27/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import UIKit

class TimeLineTableViewController: UITableViewController {

    var StatusesData:[Status] = [
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
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return StatusesData.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostStatus", for: indexPath) as! PostStatusTableViewCell
            return cell
        }
        else{
            let i = indexPath.row - 1
            if StatusesData[i].type == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "Status01", for: indexPath) as! Status01TableViewCell
                cell.lblUserName01.text! = StatusesData[i].userName!
                cell.imgAva01.image = StatusesData[i].avatar
                cell.lblStatus01.text! = StatusesData[i].content!
                cell.imgImage.image = StatusesData[i].image
                
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "Status02", for: indexPath) as! Status02TableViewCell
                cell.imgAva02.image = StatusesData[i].avatar
                cell.lblUserName02.text! = StatusesData[i].userName!
                cell.lblContent.text! = StatusesData[i].content!
                
                return cell
            }
        }
    }
    
    
    @IBAction func backToTimelineController(segue:UIStoryboardSegue) {
        print(1)
    }
    
    @IBAction func saveStatus(segue:UIStoryboardSegue) {
        scheduleDemoLocalNotif()
        if let newStatusViewController = segue.source as? NewStatusViewController{
            if let status = newStatusViewController.status{
                self.StatusesData.insert(status, at: 0)
                tableView.beginUpdates()
                tableView.insertRows(at: [IndexPath.init(row: 1, section: 0)], with: .automatic)
                tableView.endUpdates()
            }
        }
    }
    
    func scheduleDemoLocalNotif() {
        let demoNotif = UILocalNotification()
        demoNotif.fireDate = NSDate(timeIntervalSinceNow: 10) as Date
        demoNotif.timeZone = NSTimeZone.default
        
        demoNotif.alertBody = "You have new status"
        demoNotif.alertAction = "View"
        demoNotif.applicationIconBadgeNumber = 1
        let infoDict = [
            "msg": "You have new status"
        ]
        demoNotif.userInfo = infoDict
        UIApplication.shared.scheduleLocalNotification(demoNotif)
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
