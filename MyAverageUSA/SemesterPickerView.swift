//
//  SemesterPickerView.swift
//  MyAverageUSA
//
//  Created by Jonathan  Wesfield on 2017-07-03.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import Foundation
import UIKit

class SemesterPickerView: UIPickerView, UIPickerViewDelegate , UIPickerViewDataSource {
    
    
    private var semesters = [Sem.A , Sem.B, Sem.C]
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return semesters.count
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(semesters[row])"
    }
    
    
}
