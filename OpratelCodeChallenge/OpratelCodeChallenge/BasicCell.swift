//
//  BasicCell.swift
//  OpratelCodeChallenge
//
//  Created by alvaro sebastian leon romero on 4/6/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import UIKit

class BasicCell: UITableViewCell {

    @IBOutlet weak var viewStick: UIView!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var labelMonth: UILabel!
    @IBOutlet weak var labelDay: UILabel!
    @IBOutlet weak var labelSubject: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewDate.layer.cornerRadius = CGRectGetWidth(self.viewDate.frame)/2
        self.viewDate.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
