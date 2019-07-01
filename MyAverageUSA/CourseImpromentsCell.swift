//
//  CourseImpromentsCell.swift
//  MyAverageUSA
//
//  Created by Jonathan  Wesfield on 2017-07-09.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import UIKit
import ValueStepper


func numberFromLetter(i_Letter : String) -> Double {
    switch (i_Letter) {
    case "A+":
        return 12
    case "A":
        return 11
    case "A-":
        return 10
    case "B+":
        return 9
    case "B":
        return 8
    case "B-":
        return 7
    case "C+":
        return 6
    case "C":
        return 5
    case "C-":
        return 4
    case "D+":
        return 3
    case "D":
        return 2
    case "D-":
        return 1
    default:
        return 0
    }
}

func letterFromNumber(i_Number : Double) -> String {
    switch (i_Number) {
    case 12:
        return "A+"
    case 11:
        return "A"
    case 10:
        return "A-"
    case 9:
        return "B+"
    case 8:
        return "B"
    case 7:
        return "B-"
    case 6:
        return "C+"
    case 5:
        return "C"
    case 4:
        return "C-"
    case 3:
        return "D+"
    case 2:
        return "D"
    case 1:
        return "D-"
    default:
        return "F"
    }
}


class CourseImpromentsCell: UITableViewCell {

    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var increseLabel: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    
    var prevValue = 0.0
    var data : Improments!
    var current_Course: Course!
    var grade = 0.0
    var parentView : CourseImprovmentsVC!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }

    
    
    
    @IBAction func stepperPressed(_ sender: Any) {
        
        // print("prev value: \( prevValue) stepper value:  \(stepper.value)")
        if let d = data {
            
            if(stepper.value > prevValue){
                d.updateValues(i_CourseIndex: self.tag, i_IsIncreasing: true)
                
            } else {
                
                d.updateValues(i_CourseIndex: self.tag, i_IsIncreasing: false)
            }
            
            prevValue = stepper.value
            
        }
        if(self.stepper.value > grade){
            //self.increseLabel.text = "\(CheckedCoursesArray[tag].course.Grade)"
            self.increseLabel.text = "\(letterFromNumber(i_Number: self.stepper.value))"
            //  print(" inc : \(letterFromNumber(i_Number: self.stepper.value))")
            self.increseLabel.textColor = UIColor.green
        } else if (self.stepper.value < grade){
            // self.increseLabel.text = "\(CheckedCoursesArray[tag].course.Grade)"
            self.increseLabel.text = "\(letterFromNumber(i_Number: self.stepper.value))"
            // print(" dec : \(letterFromNumber(i_Number: self.stepper.value))")
            self.increseLabel.textColor = UIColor.red
        } else{
            //  self.increseLabel.text = "\(CheckedCoursesArray[tag].course.Grade)"
            self.increseLabel.text = "\(letterFromNumber(i_Number: self.stepper.value))"
            // print(" same : \(letterFromNumber(i_Number: self.stepper.value))")
            self.increseLabel.textColor = UIColor.black
        }
        
        
            parentView.loadValuesToView()
        
    }
   
    
    func configureCell (i_Course : Course , i_Data : Improments , i_ParentView : CourseImprovmentsVC){
        self.nameLabel.text = i_Course.Name
        self.gradeLabel.text = "\(i_Course.Grade)"
        self.stepper.value = numberFromLetter(i_Letter: i_Course.Grade)
        self.prevValue = numberFromLetter(i_Letter: i_Course.Grade)
        self.data = i_Data
        self.current_Course = i_Course
        self.grade = numberFromLetter(i_Letter: i_Course.Grade)
        
        self.increseLabel.text = i_Course.Grade
        self.increseLabel.textColor = UIColor.black
        parentView = i_ParentView
        
        stepper.stepValue = 1
        stepper.maximumValue = 12
        stepper.minimumValue = 0
        
        
        
        
    }
    
    
    
}
