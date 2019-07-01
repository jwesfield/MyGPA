//
//  Improvments.swift
//  MyAverageUSA
//
//  Created by Jonathan  Wesfield on 2017-07-09.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import Foundation



class Improments {
    
    
    /** Data Members **/
    
    private var m_Courses: [Course]!
    private var m_CurrentAllSemesters : [Semester]!
    
    private var m_IsOneSemester = true
    private var m_IsOneYear = true
    
    private var m_CurrentSem  = Semester(i_Semester: Sem.D, i_GPA: 0.0, i_Credits: 0.0, i_Year: 5)
    private var m_CurrentYear : Int!
    
    private var m_IsIncreaseSemester = false
    private var m_IsIncreaseYear = false
    private var m_IsIncreaseTotal = false
    
    
    private var m_InitialTotalGPA : Double!
    private var m_InitialYearGPA : Double!
    private var m_InitialSemesterGPA : Double!
    
    
    /** Getters and Setters **/
    
    public var Courses: [Course] {
        get { return self.m_Courses; }
    }
    public var IsOneSemester: Bool {
        get { return self.m_IsOneSemester; }
    }
    public var IsOneYear: Bool {
        get { return self.m_IsOneYear; }
    }
    public var CurrentSemester: Semester {
        get { return self.m_CurrentSem; }
    }
    public var CurrentYear: Int {
        get { return self.m_CurrentYear; }
    }
    
    public var InitialTotalGPA: Double {
        get { return self.m_InitialTotalGPA; }
    }
    public var InitialYearGPA: Double {
        get { return self.m_InitialYearGPA; }
    }
    public var InitialSemesterGPA: Double {
        get { return self.m_InitialSemesterGPA; }
    }
    
    
    init(i_Courses : [Course]) {
        
        self.m_Courses = i_Courses
        
        if(m_Courses.count < 1){
            return
        }
        
      
         self.m_CurrentAllSemesters = AllSemestersCopy
        
        isOneYear()
        isOneSemester()
    
        m_InitialTotalGPA = TotalGPA
        
        if(self.m_IsOneYear){
            m_InitialYearGPA = YearGPA
        }
        if(self.m_IsOneSemester){
            m_InitialSemesterGPA = SemesterGPA
        }
        
        
    }
    
    

    
    
    func updateValues(i_CourseIndex : Int , i_IsIncreasing : Bool){
        
        //let currentCourse = self.m_Courses[i_CourseIndex]
        
        updateLetters(i_Index: i_CourseIndex, i_Increasing: i_IsIncreasing)
        
        if(IsOneSemester){
            self.m_CurrentSem.CalculateSemesterAverage()
        }
        
    }
    

    func updateLetters(i_Index : Int , i_Increasing : Bool){
        let currentCourse = self.m_Courses[i_Index]
        // print(" current course : \(currentCourse.Name) \(currentCourse.Grade)")
        for semester in self.m_CurrentAllSemesters {
            for course in semester.Courses {
                
                if(currentCourse == course){
                    //    print(" actual course : \(course.Name) \(course.Grade)")
                    var newLetter = "A+"
                    if(i_Increasing){
                        newLetter =  letterImprove(i_Course: currentCourse)
                        course.Grade = newLetter
                        // currentCourse.Grade = newLetter
                        
                    } else {
                        newLetter = letterUnImprove(i_Course : currentCourse)
                        course.Grade = newLetter
                        // currentCourse.Grade = newLetter
                    }
                    
                    return
                }
            }
        }
    }
    
  
    
    
    public var TotalGPA : Double {
       
        var GPA = 0.0
        var totalCredits = 0.0
        
        for i in m_CurrentAllSemesters{
            for j in i.Courses{
                if(j.CountTowardsGPA == true){
                    GPA +=  Double(GPAWeights.GetGPAWeight(i_LetterGrade: j.Grade)) * j.Credits
                    totalCredits += j.Credits
                }
            }
        }

        GPA /= totalCredits
       
        return GPA.isNaN ? 0.0 : GPA
    }
    
    
    public var YearGPA : Double {
        
        var GPA = 0.0
        var totalCredits = 0.0
        
        for i in m_CurrentAllSemesters{
            for j in i.Courses{
                if(i.Year == m_CurrentYear){
                    //print(j.Name)
                    if(j.CountTowardsGPA){
                        GPA +=  Double(GPAWeights.GetGPAWeight(i_LetterGrade: j.Grade)) * j.Credits
                        totalCredits += j.Credits
                    }
                }
            }
        }
        
        GPA /= totalCredits
    
        return GPA.isNaN ? 0.0 : GPA
    }
    
 
    public var SemesterGPA : Double {
        
        var GPA = 0.0
        var totalCredits = 0.0
        
        for i in m_CurrentAllSemesters{
            if(i == m_CurrentSem){
                for j in i.Courses{
                    if(j.CountTowardsGPA == true){
                        GPA +=  Double(GPAWeights.GetGPAWeight(i_LetterGrade: j.Grade)) * j.Credits
                        totalCredits += j.Credits
                    }
                }
            }
        }
        
        GPA /= totalCredits
        
        return GPA.isNaN ? 0.0 : GPA
    }
    
    
    private func isOneYear(){
        let firstSem = self.m_Courses[0].Year
        for i in self.m_Courses{
            if(i.Year != firstSem){
                self.m_IsOneYear = false
                return
            }
        }
        self.m_IsOneYear = true
        self.m_CurrentYear = self.m_Courses[0].Year
    }
    
    private func isOneSemester(){
        let firstSem = self.m_Courses[0].ParentSemester
        for i in self.m_Courses {
            if(i.ParentSemester != firstSem){
                self.m_IsOneSemester = false
                return
            }
        }
        self.m_IsOneSemester = true
        self.m_CurrentSem = self.m_Courses[0].ParentSemester
    }
    
    func letterImprove(i_Course : Course) -> String {
        
        switch (i_Course.Grade) {
        case "A+":
            return "A+"
        case "A":
            return "A+"
        case "A-":
            return "A"
        case "B+":
            return "A-"
        case "B":
            return "B+"
        case "B-":
            return "B"
        case "C+":
            return "B-"
        case "C":
            return "C+"
        case "C-":
            return "C"
        case "D+":
            return "C-"
        case "D":
            return "D+"
        case "D-":
            return "D"
        default:
            return "D-"
        }
    }
    
    func letterUnImprove(i_Course : Course) -> String {
        
        switch (i_Course.Grade) {
        case "A+":
            return "A"
        case "A":
            return "A-"
        case "A-":
            return "B+"
        case "B+":
            return "B"
        case "B":
            return "B-"
        case "B-":
            return "C+"
        case "C+":
            return "C"
        case "C":
            return "C-"
        case "C-":
            return "D+"
        case "D+":
            return "D"
        case "D":
            return "D-"
        default:
            return "F"
        }
    }
    
}
