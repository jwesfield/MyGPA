//
//  Course.swift
//  MyAverageUSA
//
//  Created by Jonathan  Wesfield on 2017-07-03.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import Foundation
import UIKit

class Course : Equatable {
    
    
    /** Data Members **/
    
    private var m_Name : String!
    private var m_Grade : String!
    private var m_Credits : Double!
    private var m_Year : Int!
    private var m_ParentSemester : Semester!
    private var m_Semester : Sem!
    private var m_CountTowardsGPA : Bool!
    
    
    /** Getters and Setters **/
    
    var Name: String {
        get { return self.m_Name; }
        set { self.m_Name = newValue; }
    }
    
    var Grade: String {
        get { return self.m_Grade; }
        set { self.m_Grade = newValue; }
    }
    
    var Credits: Double {
        get { return self.m_Credits; }
        set { self.m_Credits = newValue; }
    }
    
    var Year: Int {
        get { return self.m_Year; }
        set { self.m_Year = newValue; }
    }
    
    var ParentSemester : Semester {
        get { return self.m_ParentSemester; }
        set { self.m_ParentSemester = newValue; }
    }
    
    var Semester: Sem {
        get { return self.m_Semester; }
        set { self.m_Semester = newValue; }
    }
    
    var CountTowardsGPA: Bool {
        get { return self.m_CountTowardsGPA; }
        set { self.m_CountTowardsGPA = newValue; }
    }
    
    
    /** Constructor **/
    
    init(i_Name: String, i_Grade: String , i_Credits : Double , i_Year: Int , i_Parent : Semester , i_CountTowardsGPA : Bool){
        
        self.m_Semester = i_Parent.SemesterLetter
        self.m_Name = i_Name
        self.m_Grade = i_Grade
        self.m_Credits = i_Credits
        self.m_Year = i_Parent.Year
        self.m_ParentSemester = i_Parent
        self.m_CountTowardsGPA = i_CountTowardsGPA
        
    }
    
    
    public static func ==(left: Course, right: Course) -> Bool {
        return (left.Name == right.Name) && (left.Grade == right.Grade) && (left.Semester == right.Semester) && (left.Year == right.Year)
    }
    
     public var Grades = ["A+" ,  "A" , "A-","B+" ,  "B" , "B-","C+" ,  "C" , "C-","D+" ,  "D" , "D-", "F"]
    
}
