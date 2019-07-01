//
//  SemesterCell.swift
//  MyAverageUSA
//
//  Created by Jonathan  Wesfield on 2017-07-03.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import Foundation

import UIKit

class SemesterCell: UITableViewCell {
    
    @IBOutlet weak var semesterNameLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell (i_Semester : Semester){
        
        // self.nameLabel.text = "\(i_Semester.Year)"
        self.semesterNameLabel.text = "\(i_Semester.SemesterLetter)"
        self.averageLabel.text = "\(i_Semester.GPA.roundToDecimal(2))"
        self.creditsLabel.text = "\(i_Semester.Credits.roundToDecimal(1))"
        self.nameLabel.text = "\(i_Semester.Year)"
    }
    
}
