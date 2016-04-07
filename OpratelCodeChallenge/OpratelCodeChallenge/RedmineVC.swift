//
//  RedmineVC.swift
//  OpratelCodeChallenge
//
//  Created by alvaro sebastian leon romero on 4/7/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

class RedmivarC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var tableview: UITableView!
    let basicCellIdentifier = "BasicCell"
    var issues = [String: AnyObject]()
    var modelArray:[AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.downloadIssues("AllIssues") { (dict) in
            self.tableview.reloadData()
        }
    }
    
    func configureTableView() {
        
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.estimatedRowHeight = 160.0
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        deselectAllRows()
    }
    
    func deselectAllRows() {
        if let selectedRows = self.tableview.indexPathsForSelectedRows as [NSIndexPath]! {
            for indexPath in selectedRows {
                self.tableview.deselectRowAtIndexPath(indexPath, animated: false)
            }
        }
    }
    
    func downloadIssues(content:String, completion:(NSArray) -> Void){
        showProgressHUD()
        Alamofire.request(ConnectionRouter.Issues(content))
            .responseJSON { response in
                guard response.result.isSuccess else{
                    print("Error while fetching all issues: \(response.result.error)")
                    self.hideProgressHUD()
                    completion([NSArray]())
                    return
                }
                
                if let responseJSON = response.result.value as? [String:AnyObject] {
                    let issues = responseJSON["issues"]
                    for singleIssue in issues! as! [AnyObject]{
                        
                        let author = IssueModel.Author(id:singleIssue.valueForKey("author")?.valueForKey("id") as! Int,name: singleIssue.valueForKey("author")?.valueForKey("name") as! String)
                        
                        let priority = IssueModel.Priority(id:singleIssue.valueForKey("priority")?.valueForKey("id") as! Int,name: singleIssue.valueForKey("priority")?.valueForKey("name") as! String)
                        
                        let status = IssueModel.Status(id:singleIssue.valueForKey("status")?.valueForKey("id") as! Int,name: singleIssue.valueForKey("status")?.valueForKey("name") as! String)
                        
                        let tracker = IssueModel.Tracker(id:singleIssue.valueForKey("tracker")?.valueForKey("id") as! Int,name: singleIssue.valueForKey("tracker")?.valueForKey("name") as! String)
                        
                        let project = IssueModel.Project(id:singleIssue.valueForKey("project")?.valueForKey("id") as! Int,name: singleIssue.valueForKey("project")?.valueForKey("name") as! String)
                        
                        var assigned:IssueModel.AssignedTo?
                        if (singleIssue.valueForKey("assigned_to") != nil){
                            let assignedTo = IssueModel.AssignedTo(id:singleIssue.valueForKey("assigned_to")?.valueForKey("id") as! Int,name: singleIssue.valueForKey("assigned_to")?.valueForKey("name") as! String)
                            assigned = assignedTo
                        }else{
                            assigned = IssueModel.AssignedTo(id: 0, name: "")
                        }
                        
                        let createdOn = self.StringToDate(singleIssue.valueForKey("created_on")as! String)
                        let updatedOn = self.StringToDate(singleIssue.valueForKey("updated_on")as! String)
                        
                        
                        var hours:Int
                        if (singleIssue.valueForKey("estimated_hours") != nil){
                            hours = singleIssue.valueForKey("estimated_hours") as! Int
                        }else{
                            hours = 0
                        }
                        var dueDate:String
                        if (singleIssue.valueForKey("due_date") != nil){
                            dueDate = singleIssue.valueForKey("due_date") as! String
                        }else{
                            dueDate = ""
                        }

                        let model = IssueModel(author: author, created_on: createdOn, description: singleIssue.valueForKey("description") as! String, done_ratio: singleIssue.valueForKey("done_ratio") as! Int, id: singleIssue.valueForKey("id") as! Int, priority: priority, project: project, start_date: singleIssue.valueForKey("start_date") as! String, status: status, subject: singleIssue.valueForKey("subject")as! String, tracker: tracker, updated_on: updatedOn,assignedTo:assigned!,estimatedHours:hours,due_date: dueDate)
                        
                        self.modelArray.append(model)
                    }
                }else{
                    print("Invalid data type received")
                    self.hideProgressHUD()
                    completion(NSArray())
                    return
                }
                self.hideProgressHUD()
                completion(self.modelArray)
        }
    }
    
    func StringToDate(dateStringFormat:String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.dateFromString(dateStringFormat)
        return date!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.modelArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return basicCellAtIndexPath(indexPath)
    }
    
    
    func basicCellAtIndexPath(indexPath:NSIndexPath) -> BasicCell {
        let cell = self.tableview.dequeueReusableCellWithIdentifier(basicCellIdentifier) as! BasicCell
        setSubjectForCell(cell, indexPath: indexPath)
        setDescriptionForCell(cell, indexPath: indexPath)
        setMonthForCell(cell, indexPath: indexPath)
        setDayForCell(cell, indexPath: indexPath)
        
        cell.viewDate.layer.cornerRadius = CGRectGetWidth(cell.viewDate.frame)/2
        cell.viewDate.layer.masksToBounds = true
        return cell
    }
    
    func setSubjectForCell(cell:BasicCell,indexPath:NSIndexPath) {
        let item = self.modelArray[indexPath.row] as! IssueModel
        cell.labelSubject.text = "Subject: " + item.subject! ?? "[No subject]"
    }
    func setDescriptionForCell(cell:BasicCell,indexPath:NSIndexPath) {
        let item = self.modelArray[indexPath.row] as! IssueModel
        cell.labelDescription.text = "Description: " + item.description! ?? "[No description]"
    }
    func setMonthForCell(cell:BasicCell,indexPath:NSIndexPath) {
        let item = self.modelArray[indexPath.row] as! IssueModel
        cell.labelMonth.text = self.getMonthWithDate(item.created_on!)
    }
    
    func setDayForCell(cell:BasicCell,indexPath:NSIndexPath) {
        let item = self.modelArray[indexPath.row] as! IssueModel
        cell.labelDay.text = self.getDayWithDate(item.created_on!)
    }
    
    func getMonthWithDate(date:NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.stringFromDate(date)
        let month = self.getMonthAcronym(date)
        return month
    }
    
    func getDayWithDate(date:NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.stringFromDate(date)
        let day = self.getDayForCell(date)
        return day
    }
    
    func getMonthAcronym(fecha:String) -> String {
        var dateSplited = fecha.componentsSeparatedByString("-")
        var month:String
        
        switch dateSplited[1] {
        case "01":
            month = "ENE"
            return (month)
        case "02":
            month = "FEB"
            return (month)
        case "03":
            month = "MAR"
            return (month)
        case "04":
            month = "APR"
            return (month)
        case "05":
            month = "MAY"
            return (month)
        case "06":
            month = "JUN"
            return (month)
        case "07":
            month = "JUL"
            return (month)
        case "08":
            month = "AUG"
            return (month)
        case "09":
            month = "SEP"
            return (month)
        case "10":
            month = "OCT"
            return (month)
        case "11":
            month = "NOV"
            return (month)
        case "12":
            month = "DIC"
            return (month)
        default:
            return("")
        }
    }
    
    func getDayForCell(fecha:String) -> String {
        let date = fecha.stringByReplacingOccurrencesOfString("T", withString: "-")
        var dateSplited = date.componentsSeparatedByString("-")
        let day = dateSplited[2]
        return day
    }
    
    //Mark NAvigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = self.tableview.indexPathForSelectedRow
        let item = self.modelArray[indexPath!.row]
        let redMineDetail = segue.destinationViewController as! RedmineDetail
        redMineDetail.item = item as? IssueModel
        
    }
    
    func showProgressHUD() {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.labelText = "Loading"
    }
    
    func hideProgressHUD() {
        MBProgressHUD.hideAllHUDsForView(view, animated: true)
    }
    
    

}
