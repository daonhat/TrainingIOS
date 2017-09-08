//
//  TimeLineTableViewController.swift
//  TrainingIOS
//
//  Created by mod bibi on 7/27/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import UIKit
import Alamofire

class TimeLineTableViewController: UITableViewController, StatusCellDelegate, PostCellDelegate {

    var statusesData:[Status] = []
    var refresher: UIRefreshControl! = UIRefreshControl()
    let baseTimeLineURL = "https://us-central1-travelworld-5d555.cloudfunctions.net/v1"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(hex: "e9ebee")
        
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: "PostStatusTableViewCell", bundle: nil), forCellReuseIdentifier: "PostStatus")
        self.tableView.register(UINib(nibName: "Status01TableViewCell", bundle: nil), forCellReuseIdentifier: "Status01")
        self.tableView.register(UINib(nibName: "Status02TableViewCell", bundle: nil), forCellReuseIdentifier: "Status02")
        self.tableView.register(UINib(nibName: "RefreshTableViewCell", bundle: nil), forCellReuseIdentifier: "RefreshCell")
        
        self.tableView.estimatedRowHeight = 300
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.allowsSelection = false
        
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(self.refreshTableView), for: UIControlEvents.valueChanged)
        
        if #available(iOS 10.0, *){
            self.tableView.refreshControl = refresher
        }
        else{
            self.tableView.addSubview(refresher)
        }
        
        self.callTimelineAPI()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.newStatus(_:)), name: NSNotification.Name(rawValue: "newStatus"), object: nil)
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return statusesData.count + 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostStatus", for: indexPath) as! PostStatusTableViewCell
            cell.delegate = self
            return cell
        }
        else if indexPath.row == statusesData.count + 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RefreshCell", for: indexPath) as! RefreshTableViewCell
            cell.startStopLoading(false)
            return cell
        }
        else{
            let i = indexPath.row - 1
            if statusesData[i].type! == "status"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "Status02", for: indexPath) as! Status02TableViewCell
                
                cell.indexPath          = indexPath
                cell.imgAva02.image     = #imageLiteral(resourceName: "ic_ava_1")
                cell.lblUserName02.text = "Andrea Kim"
                cell.lblLikes.text      = "\(String(describing: statusesData[i].like_cnt!)) Likes    "
                cell.lblComments.text   = "\(String(describing: statusesData[i].comment_cnt!)) Comments    "
                cell.lblContent.text    = statusesData[i].status!
                cell.delegate = self
                
                return cell

            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "Status01", for: indexPath) as! Status01TableViewCell
                
                cell.indexPath              = indexPath
                cell.lblUserName01.text     = statusesData[i].userName!
                cell.imgAva01.image         = statusesData[i].avatar
                cell.lblStatus01.text       = statusesData[i].content!
                cell.imgImage.image         = statusesData[i].image
                cell.delegate = self
                
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let lastItem = statusesData.count
//        
//        if indexPath.row == lastItem{
//            self.callTimelineAPI()
//        }
        if indexPath.row == statusesData.count + 1{
            cell.contentView.backgroundColor = UIColor(hex: "e9ebee")
        }
    
    }
    
    // MARK: - ScrollView Delegate
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 50.0 {
            self.callTimelineAPI()
            let lastCellIndexPath = IndexPath(row:statusesData.count + 1 , section: 0)
            let refreshCell = self.tableView.cellForRow(at: lastCellIndexPath) as! RefreshTableViewCell
            refreshCell.startStopLoading(true)
        }
    }
    
    // MARK: - Call API
    
    func callTimelineAPI() {
        // Using APIClient and TimelineRouter for wrap
        
       let request = ApiClient.request(urlRequest: TimelineRouter.getTimeline(), completionHandler: { [weak self](responseObject) in
            guard self != nil else { return }
            if responseObject?.result == .success {
                if let jsonObj = responseObject?.data as? NSArray{
                    for status in jsonObj {
                        let statusLoad = Status(jsonObject: status as AnyObject)
                        self?.statusesData.append(statusLoad)
                    }
                    DispatchQueue.main.async{
                        self?.tableView.reloadData()
                    }
                }
            } else {
                if responseObject?.result == .error {
                    print(responseObject?.statusCode ?? "")
                }
            }
        })
        
        
        
        /* Using Alamofire
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "authorization": "JWT eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9"
        ]
        
        Alamofire.request(self.baseTimeLineURL+"/timeline", headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                    if let jsonObj = response.value as? NSArray{
                        for status in jsonObj {
                            let statusLoad = Status(jsonObject: status as AnyObject)
                            self.statusesData.append(statusLoad)
                        }
                        DispatchQueue.main.async{
                            self.tableView.reloadData()
                        }
                    }
            case .failure(let error):
                print(error)
                return
            }
        }
        */
        
        /* Using URLRequest Default
        
        DispatchQueue.global().async {
            
            var request = URLRequest(url:URL(string: self.baseTimeLineURL+"/timeline")!)

            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("JWT eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9", forHTTPHeaderField: "authorization")
            let session = URLSession.shared
            session.dataTask(with: request, completionHandler:{(data, response, error) -> Void in
                
                if error != nil {
                    print("\(String(describing: error))")
                    return
                }
                
                guard let data = data else{
                    print("no data return")
                    return
                }
                
                
                if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSArray{
        
                    for status in jsonObj! {
                        let statusLoad = Status(jsonObject: status as AnyObject)
                        self.statusesData.append(statusLoad)
                    }
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                    }
                }
            }).resume()
        }
        */
    }
    
    func didTapCmt(in indexPath: IndexPath!) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "CommentViewController") as! CommentViewController
        secondViewController.status = statusesData[indexPath.row - 1]
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func didTapPost() {
        let newStatus = self.storyboard!.instantiateViewController(withIdentifier: "NewStatus") as! NewStatusViewController
        
        let navController = UINavigationController(rootViewController: newStatus)
        addTransitionForAction(subtype:kCATransitionFromLeft)
        self.present(navController, animated:false, completion: nil)
    }
    
    func newStatus(_ notification: NSNotification)  {
        if let status = notification.userInfo?["new_status"] as? Status {
            self.statusesData.insert(status, at: 0)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    func refreshTableView() {
        self.statusesData.shuffle()
        self.tableView.reloadData()
        refresher.endRefreshing()
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
