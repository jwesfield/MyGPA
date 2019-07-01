//
//  CourseCell.swift
//  MyAverageUSA
//
//  Created by Jonathan  Wesfield on 2017-07-03.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import Foundation
import UIKit
import UICircularProgressRing

class CourseCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
     @IBOutlet weak var gradeRing: UICircularProgressRingView!
    
    @IBOutlet weak var ringLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell (i_Course : Course){
        
        nameLabel.text = i_Course.Name
        gradeLabel.text = "Grade : \(i_Course.Grade)"
        creditsLabel.text = "Credits : \(i_Course.Credits)"
        //  gradeRing.value = CGFloat(i_Course.Grade)
        gradeRing.value = CGFloat(numberFromLetter(i_Letter: i_Course.Grade))
        gradeRing.maxValue = 12
        gradeRing.shouldShowValueText = false
        ringLabel.text = i_Course.Grade
        
    }
    
}
