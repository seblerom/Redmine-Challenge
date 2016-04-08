//
//  IssueModelDetail.swift
//  OpratelCodeChallenge
//
//  Created by alvaro sebastian leon romero on 4/8/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import UIKit

class IssueModelDetail: IssueModel {

    var spent_hours: Int?
    
    init(author: IssueModel.Author, created_on: NSDate, description: String, done_ratio: Int, id: Int, priority: IssueModel.Priority, project: IssueModel.Project, start_date: String, status: IssueModel.Status, subject: String, tracker: IssueModel.Tracker, updated_on: NSDate, assignedTo: IssueModel.AssignedTo, estimatedHours: Int, due_date: String, spent_hours:Int) {
        self.spent_hours = spent_hours
        super.init(author: author, created_on: created_on, description: description, done_ratio: done_ratio, id: id, priority: priority, project: project, start_date: start_date, status: status, subject: subject, tracker: tracker, updated_on: updated_on, assignedTo: assignedTo, estimatedHours: estimatedHours, due_date: due_date)
    }
    
}
