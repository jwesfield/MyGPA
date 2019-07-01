//
//  CourseCheckCell.swift
//  MyAverageUSA
//
//  Created by Jonathan  Wesfield on 2017-07-09.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import UIKit
import M13Checkbox

class CourseCheckCell: UITableViewCell {

    /** IBOutlets **/
    @IBOutlet weak var checkBox: M13Checkbox!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    
    /** Data Members **/
    private var currentCourseCheck : courseCheck!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func checkBoxChecked(_ sender: Any) {
        
        if (checkBox.checkState == .checked){
            CheckedCoursesArray[currentCourseCheck.index].setState(state: true)
        } else if(checkBox.checkState == .unchecked){
            CheckedCoursesArray[currentCourseCheck.index].setState(state: false)
        }
        
    }
    
    /** Init Cell **/
    func configureCell(NewClass: courseCheck){
        currentCourseCheck = NewClass
        
        if(NewClass.isChecked){
            self.checkBox.checkState = .checked
        } else {
            self.checkBox.checkState = .unchecked
        }
        
        self.checkBox.stateChangeAnimation = .expand(.fill)
        
        self.nameLabel.text = "\(NewClass.course.Name)"
        self.gradeLabel.text = "Grade : \(NewClass.course.Grade)"
    }

}
