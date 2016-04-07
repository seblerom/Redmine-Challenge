//
//  IssueModel.swift
//  OpratelCodeChallenge
//
//  Created by alvaro sebastian leon romero on 4/6/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import Foundation

class IssueModel{
    
    var author:IssueModel.Author
    
    var created_on:NSDate?
    var description:String?
    var done_ratio:Int?
    var id:Int?
    var priority:IssueModel.Priority?
    var project:IssueModel.Project?
    var start_date:String?
    var status:IssueModel.Status?
    var subject:String?
    var tracker:IssueModel.Tracker?
    var updated_on:NSDate?
    
    var assignedTo:IssueModel.AssignedTo?
    var estimated_hours: Int?
    var due_date:String?
    
    struct Author {
        var id:Int?
        var name:String?
        
        init(id:Int,name:String){
            
            self.id = id
            self.name = name
            
        }
    }
    
    struct AssignedTo {
        var id:Int?
        var name:String?
        
        init(id:Int,name:String){
            
            self.id = id
            self.name = name
            
        }
    }
    
    struct Priority {
        var id:Int?
        var name:String?
        
        init(id:Int,name:String){
            
            self.id = id
            self.name = name
            
        }
    }
    
    struct Project {
        var id:Int?
        var name:String?
        
        init(id:Int,name:String){
            
            self.id = id
            self.name = name
            
        }
    }
    
    struct Status {
        var id:Int?
        var name:String?
        
        init(id:Int,name:String){
            
            self.id = id
            self.name = name
            
        }
    }
    
    struct Tracker {
        var id:Int?
        var name:String?
        
        init(id:Int,name:String){
            
            self.id = id
            self.name = name
            
        }
    }
    
    init(author:IssueModel.Author,created_on:NSDate,description:String,done_ratio:Int,id:Int,priority:IssueModel.Priority,project:IssueModel.Project,start_date:String,status:IssueModel.Status,subject:String,tracker:IssueModel.Tracker,updated_on:NSDate,assignedTo:IssueModel.AssignedTo,estimatedHours:Int,due_date:String){
        
        self.author = author
        self.created_on = created_on
        self.description = description
        self.done_ratio = done_ratio
        self.id = id
        self.priority = priority
        self.project = project
        self.start_date = start_date
        self.status = status
        self.subject = subject
        self.tracker = tracker
        self.updated_on = updated_on
        self.assignedTo = assignedTo
        self.estimated_hours = estimatedHours
        self.due_date = due_date
        
        
    }
}