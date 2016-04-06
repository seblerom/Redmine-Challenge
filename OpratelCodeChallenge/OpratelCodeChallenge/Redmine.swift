//
//  Redmine.swift
//  OpratelCodeChallenge
//
//  Created by alvaro sebastian leon romero on 4/6/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

class Redmine: UITableViewController {
    
    let basicCellIdentifier = "BasicCell"
    var issues = [String: AnyObject]()
    var iss=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.downloadIssues("AllIssues") { (dict) in
            //            self.issues = dict
            self.iss=dict
            self.transformDictionaryToArray(self.issues)
        }
    }
    
    func transformDictionaryToArray(dict:([String:AnyObject])) -> NSArray {
        var issuesArray:[AnyObject] = []
        for singleArray in dict {
            
            let issueModel=IssueModel()
            issueModel.description="tontaaa"
            issuesArray.append(issueModel)
            print(issuesArray)
            
            
            //            IssueModel.init(author: issueTypes["author"], created_on: issueTypes["created_on"], description: issueTypes["description"], done_ratio: issueTypes["done_ratio"], id: issueTypes["id"], priority: <#T##IssueModel.Priority#>, project: <#T##IssueModel.Project#>, start_date: <#T##String#>, status: <#T##IssueModel.Status#>, subject: <#T##String#>, tracker: <#T##IssueModel.Tracker#>, updated_on: <#T##NSDate#>)
            //        }
            
        }
        return issuesArray
    }
    
    func configureTableView() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        deselectAllRows()
    }
    
    func deselectAllRows() {
        if let selectedRows = tableView.indexPathsForSelectedRows as [NSIndexPath]! {
            for indexPath in selectedRows {
                tableView.deselectRowAtIndexPath(indexPath, animated: false)
            }
        }
    }
    
    //    func downloadIssues(content:String, completion:(dict:[String:AnyObject]) -> Void){
    //        Alamofire.request(ConnectionRouter.Issues(content))
    //            .responseJSON { response in
    //                guard response.result.isSuccess else{
    //                    print("Error while fetching all issues: \(response.result.error)")
    //                    completion(dict:[String:AnyObject]())
    //                    return
    //                }
    //
    //                guard let responseJSON = response.result.value as? [String:AnyObject]else{
    //                    print("Invalid data type received")
    //                    completion(dict:[String:AnyObject]())
    //                    return
    //                }
    //                completion(dict: responseJSON)
    //        }
    //    }
    
    func downloadIssues(content:String, completion:(NSArray) -> Void){
        Alamofire.request(ConnectionRouter.Issues(content))
            .responseJSON { response in
                guard response.result.isSuccess else{
                    print("Error while fetching all issues: \(response.result.error)")
                    completion([NSArray]())
                    return
                }
                
                if let responseJSON = response.result.value as? [String:AnyObject] {
                    let issues = responseJSON["issues"]
                    print(issues!.count)
                    var objectsArray:[AnyObject] = []
                    for singleIssue in issues! as! [AnyObject]{
                        print(singleIssue)
                        let model = IssueModel()
                        model.setDescription(singleIssue.valueForKey("description")as! String)
                        objectsArray.append(model)
                    }
                }else{
                    print("Invalid data type received")
                    completion(NSArray())
                    return
                }
                
//                guard let responseJSON = response.result.value as? [String:AnyObject]else{
//                    print("Invalid data type received")
//                    completion([NSArray]())
//                    return
//                }
                

                
                completion([NSArray]())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    /*
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func showProgressHUD() {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.labelText = "Loading"
    }
    
    func hideProgressHUD() {
        MBProgressHUD.hideAllHUDsForView(view, animated: true)
    }
    
    
}
