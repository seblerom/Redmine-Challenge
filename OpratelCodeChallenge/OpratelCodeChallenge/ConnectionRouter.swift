//
//  ConnectionRouter.swift
//  OpratelCodeChallenge
//
//  Created by alvaro sebastian leon romero on 4/6/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import Foundation
import Alamofire

public enum ConnectionRouter: URLRequestConvertible{

    static let baseUrlPath = "http://demo.redmine.org/issues"
    case Issues(String)
    case SingleIssue(String)
    
    public var URLRequest: NSMutableURLRequest{
    
        let result: (path:String,method:Alamofire.Method,parameters:[String:AnyObject]) = {
            switch self {
            case .Issues:
                return("json",.GET,[String: AnyObject]())
            case .SingleIssue:
                let urlExtension =  "json"
                return(urlExtension,.GET,[String: AnyObject]())
            }
        }()
        
        let URL = NSURL(string: ConnectionRouter.baseUrlPath)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathExtension(result.path))
        URLRequest.HTTPMethod = result.method.rawValue
        URLRequest.timeoutInterval = NSTimeInterval(10 * 1000)
        let encoding = Alamofire.ParameterEncoding.URL
        return encoding.encode(URLRequest, parameters: result.parameters).0
    }
    
}