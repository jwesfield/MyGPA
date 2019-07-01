//
//  Semester.swift
//  MyAverageUSA
//
//  Created by Jonathan  Wesfield on 2017-07-03.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import Foundation
import UIKit

class Semester : Equatable {
    
    
    /** Data Members **/
    
    private var m_GPA : Double!
    private var m_Credits : Double!
    private var m_Year : Int!
    private var m_SemesterLetter : Sem!
    private var m_Courses : [Course]!
    
    
    /** Getters and Setters **/
    
    var GPA: Double {
        get { return self.m_GPA; }
        set { self.m_GPA = newValue; }
    }
    
    var Credits: Double {
        get { return self.m_Credits; }
        set { self.m_Credits = newValue; }
    }
    
    var Year: Int {
        get { return self.m_Year; }
        set { self.m_Year = newValue; }
    }
    
    var SemesterLetter : Sem {
        get { return self.m_SemesterLetter; }
        set { self.m_SemesterLetter = newValue; }
    }
    
    var Courses: [Course] {
        get { return self.m_Courses; }
        set { self.m_Courses = newValue; }
    }
    
    
    /** Constructor **/
    
    init(i_Semester: Sem, i_GPA: Double , i_Credits : Double , i_Year: Int){
        
        self.m_SemesterLetter = i_Semester
        self.m_GPA = i_GPA
        self.m_Credits = i_Credits
        self.m_Year = i_Year
        self.m_Courses = [Course]()
        
    }
    
    /** Class Logic **/
    
    public func CalculateSemesterAverage(){
        
        var average = 0.0
        var credits = 0.0
        
        for i in m_Courses {
            if(i.CountTowardsGPA == true){
                average += Double(GPAWeights.GetGPAWeight(i_LetterGrade: i.Grade)) * i.Credits
                credits += i.Credits
            }
        }
        average /= credits
        
        if(average.isNaN){
            average = 0.0
        }
        
        self.m_GPA = average
        self.m_Credits = credits
    }
    
    
    public func CalculateAndReturnSemesterAverage() -> [Double] {
        var returnData = [Double]()
        returnData.append(0.0)
        returnData.append(0.0)
        
        var average = 0.0
        var credits = 0.0
        
        for i in m_Courses {
            if(i.CountTowardsGPA == true){
                average += Double(GPAWeights.GetGPAWeight(i_LetterGrade: i.Grade)) * i.Credits
                credits += i.Credits
            }
        }
        //average /= credits
        
        if(average.isNaN){
            average = 0.0
        }
        
        //returnData.append(average)
        //returnData.append(credits)
        
        returnData[0] = average
        returnData[1] = credits
        
        return returnData
    }
    
    func AddCourse(i_course: Course){
        self.m_Courses.append(i_course)
    }
    
    func RemoveCourse(i_index: Int){
        self.m_Courses.remove(at: i_index)
    }
    
    
    public static func ==(left: Semester, right: Semester) -> Bool {
        return (left.Year == right.Year) && (left.Credits == right.Credits) && (left.SemesterLetter == right.SemesterLetter) && (left.Credits == right.Credits)
    }

    
}
