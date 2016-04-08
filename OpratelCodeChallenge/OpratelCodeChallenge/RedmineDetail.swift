//
//  RedmineDetail.swift
//  OpratelCodeChallenge
//
//  Created by alvaro sebastian leon romero on 4/7/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import UIKit
import Alamofire
class RedmineDetail: UIViewController, UIScrollViewDelegate{

    
    @IBOutlet weak var labelAuthorName: UILabel!
    @IBOutlet weak var labelSubject: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelMonth: UILabel!
    @IBOutlet weak var labelDay: UILabel!
    @IBOutlet weak var labelPriority: UILabel!
    @IBOutlet weak var labelStimatedHours: UILabel!
    @IBOutlet weak var labelSpendHours: UILabel!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewStimatedHours: UIView!
    @IBOutlet weak var viewSpendHours: UIView!
    
    @IBOutlet weak var viewScroll: UIScrollView!
    var item:IssueModel?=nil
    var modelArray:[IssueModelDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        downloadIssues(String(item!.id!)) { (dict) in
            self.loadViewData()
        }
    }
    
    func prepareView() {
        self.viewDate.layer.cornerRadius = CGRectGetWidth(self.viewDate.frame)/2
        self.viewDate.layer.masksToBounds = true
        
        self.viewStimatedHours.layer.cornerRadius = CGRectGetWidth(self.viewStimatedHours.frame)/2
        self.viewStimatedHours.layer.masksToBounds = true
        
        self.viewSpendHours.layer.cornerRadius = CGRectGetWidth(self.viewSpendHours.frame)/2
        self.viewSpendHours.layer.masksToBounds = true
        
    }
    
    
    func downloadIssues(issueId:String, completion:(NSArray) -> Void){
        LoadingAnimations.showProgressHUD(self.view)
       
        Alamofire.request(.GET, "http://demo.redmine.org/issues/"+issueId+".json").responseJSON { response in
            guard response.result.isSuccess else{
                print("Error while fetching all issues: \(response.result.error)")
                LoadingAnimations.hideProgressHUD(self.view)
                completion([NSArray]())
                return
            }
            
            
            if let responseJSON = response.result.value as? [String:AnyObject] {
                let singleIssue = responseJSON["issue"]
                    let author = IssueModel.Author(id:singleIssue!.valueForKey("author")?.valueForKey("id") as! Int,name: singleIssue!.valueForKey("author")?.valueForKey("name") as! String)
                    
                    let priority = IssueModel.Priority(id:singleIssue!.valueForKey("priority")?.valueForKey("id") as! Int,name: singleIssue!.valueForKey("priority")?.valueForKey("name") as! String)
                    
                    let status = IssueModel.Status(id:singleIssue!.valueForKey("status")?.valueForKey("id") as! Int,name: singleIssue!.valueForKey("status")?.valueForKey("name") as! String)
                    
                    let tracker = IssueModel.Tracker(id:singleIssue!.valueForKey("tracker")?.valueForKey("id") as! Int,name: singleIssue!.valueForKey("tracker")?.valueForKey("name") as! String)
                    
                    let project = IssueModel.Project(id:singleIssue!.valueForKey("project")?.valueForKey("id") as! Int,name: singleIssue!.valueForKey("project")?.valueForKey("name") as! String)
                    
                    var assigned:IssueModel.AssignedTo?
                    if (singleIssue!.valueForKey("assigned_to") != nil){
                        let assignedTo = IssueModel.AssignedTo(id:singleIssue!.valueForKey("assigned_to")?.valueForKey("id") as! Int,name: singleIssue!.valueForKey("assigned_to")?.valueForKey("name") as! String)
                        assigned = assignedTo
                    }else{
                        assigned = IssueModel.AssignedTo(id: 0, name: "")
                    }
                    
                    let createdOn = DateManagement.StringToDate(singleIssue!.valueForKey("created_on")as! String)
                    let updatedOn = DateManagement.StringToDate(singleIssue!.valueForKey("updated_on")as! String)
                    
                    var hours:Int
                    if (singleIssue!.valueForKey("estimated_hours") != nil){
                        hours = singleIssue!.valueForKey("estimated_hours") as! Int
                    }else{
                        hours = 0
                    }
                    var dueDate:String
                    if (singleIssue!.valueForKey("due_date") != nil){
                        dueDate = singleIssue!.valueForKey("due_date") as! String
                    }else{
                        dueDate = ""
                    }
                    
                    let modelDetail = IssueModelDetail(author: author, created_on: createdOn, description: singleIssue!.valueForKey("description") as! String, done_ratio: singleIssue!.valueForKey("done_ratio") as! Int, id: singleIssue!.valueForKey("id") as! Int, priority: priority, project: project, start_date: singleIssue!.valueForKey("start_date") as! String, status: status, subject: singleIssue!.valueForKey("subject")as! String, tracker: tracker, updated_on: updatedOn,assignedTo:assigned!,estimatedHours:hours,due_date: dueDate, spent_hours:singleIssue!.valueForKey("spent_hours") as! Int)
                    
                    self.modelArray.append(modelDetail)
                
            }else{
                print("Invalid data type received")
                LoadingAnimations.hideProgressHUD(self.view)
                completion(NSArray())
                return
            }
            LoadingAnimations.hideProgressHUD(self.view)
            completion(self.modelArray)
            
        }
    }
    
    func loadViewData() {
        self.labelAuthorName.text =  item?.author.name
        self.labelSubject.text = "Subject: " + (item?.subject)!
        self.labelDescription.text = "Description: " + (item?.description)!
        self.labelMonth.text = DateManagement.getMonthWithDate((item?.created_on)!)
        self.labelDay.text = DateManagement.getDayWithDate(item!.created_on!)
        self.labelStimatedHours.text = String(item!.estimated_hours!)
        self.labelPriority.text = item?.priority?.name
        let spentHours = self.modelArray[0].spent_hours!
        self.labelSpendHours.text = String(spentHours)
        

    }
}
