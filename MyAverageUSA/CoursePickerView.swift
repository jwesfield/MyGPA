//
//  CoursePickerView.swift
//  MyAverageUSA
//
//  Created by Jonathan  Wesfield on 2017-07-05.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import Foundation
import UIKit

class CoursePickerView: UIPickerView, UIPickerViewDelegate , UIPickerViewDataSource {
    

     private var gradesOptions = ["A+" ,  "A" , "A-","B+" ,  "B" , "B-","C+" ,  "C" , "C-","D+" ,  "D" , "D-", "F "]
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gradesOptions.count
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(gradesOptions[row])"
    }
    
    
}
