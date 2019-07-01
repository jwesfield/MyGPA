//
//  GlobalData.swift
//  MyAverageUSA
//
//  Created by Jonathan  Wesfield on 2017-07-03.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import Foundation
import Firebase






let tempView = UIViewX()


var AllSemesters = [Semester]()
var GPAWeights = GPAConversion(standard: "standard");


public enum Sem {
    case A
    case B
    case C
    case D
}


extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
       
        return Darwin.round(self * multiplier) / multiplier
    }
}

extension Float {
    func roundToDecimal(_ fractionDigits: Int) -> Float {
        let multiplier = pow(10, Float(fractionDigits))
        
        return Darwin.round(self * multiplier) / multiplier
    }
}



 func SemesterListToDictionary() -> [[Dictionary<String , String>]]{
    
    var InfoDic = [[Dictionary<String, String>]]()
    
    for semester in AllSemesters {
        
        var SemesterDic = [Dictionary<String, String>]()
        
        for course in semester.Courses {
            
            var courseDic = Dictionary<String, String>()
            
            courseDic["CourseName"] = "\(course.Name)"
            courseDic["CourseGrade"] = "\(course.Grade)"
            courseDic["CourseCredits"] = "\(course.Credits)"
            courseDic["CourseSemester"] = "\(course.Semester)"
            courseDic["CourseYear"] = "\(course.Year)"
            courseDic["CourseCountForGPA"] = "\(course.CountTowardsGPA)"
            
            SemesterDic.append(courseDic)
        }
        
        var SemesterInfoDic = Dictionary<String, String>()
        SemesterInfoDic["SemesterAverage"] = "\(semester.GPA)"
        SemesterInfoDic["SemesterCredits"] = "\(semester.Credits)"
        SemesterInfoDic["SemesterYear"] = "\(semester.Year)"
        SemesterInfoDic["SemesterSem"] = "\(semester.SemesterLetter)"
        
        SemesterDic.append(SemesterInfoDic)
        InfoDic.append(SemesterDic)
        
    }
    print(InfoDic)
    print("DONE")
    return InfoDic
}


public func ArrayOfSemestersFromDictionary(){
    
    if let data = UserDefaults.standard.array(forKey: "SemesterDictionary") as? [[Dictionary<String, String>]]{
        var semestersArray = [Semester]()
        for i in data {
            var currentSemesterInfo = i.last
            var sem_Average = 0.0
            var sem_Sem = Sem.A
            var sem_credits = 0.0
            var sem_year = 1
            if let semesterCurrentAverage = currentSemesterInfo?["SemesterAverage"] {
                sem_Average = Double(semesterCurrentAverage)!
            }
            if let semesterCurrentCredits = currentSemesterInfo?["SemesterCredits"] {
                sem_credits = Double(semesterCurrentCredits)!
            }
            if let semesterCurrentSem = currentSemesterInfo?["SemesterSem"] {
                switch semesterCurrentSem  {
                case "A":
                    sem_Sem = Sem.A
                    break
                case "B" :
                    sem_Sem = Sem.B
                    break
                default:
                    sem_Sem = Sem.C
                }
            }
            if let semesterCurrentYear = currentSemesterInfo?["SemesterYear"] {
                sem_year = Int(semesterCurrentYear)!
            }
            let newSemester = Semester(i_Semester: sem_Sem, i_GPA: sem_Average, i_Credits: sem_credits, i_Year: sem_year)
            
            for j in i {
                
                if (j == i.last!) {
                    break
                }
                var name = ""
                var grade = ""
                var credits = 0.0
                var year = 0
                var countTowardGPA = true
                if let courseYear = j["CourseYear"] {
                    year = Int(courseYear)!
                }
                if let courseName = j["CourseName"] {
                    name = courseName
                }
                if let courseGrade = j["CourseGrade"] {
                    grade = courseGrade
                }
                if let courseCredits = j["CourseCredits"] {
                    credits = Double(courseCredits)!
                }
                if let countToGPA = j["CourseCountForGPA"] {
                    countTowardGPA = Bool(countToGPA)!
                }
                
                
                let newCourse = Course(i_Name: name, i_Grade: grade, i_Credits: credits, i_Year: year, i_Parent: newSemester, i_CountTowardsGPA: countTowardGPA ) // fix
                newSemester.AddCourse(i_course: newCourse)
            }
            semestersArray.append(newSemester)
        
        AllSemesters = semestersArray
        }
    } else {
        print("Sorry jonny no data POOO")
    }
}



func LoadTestData(){
    
    let sem1 = Semester(i_Semester: Sem.A, i_GPA: 0.0, i_Credits: 0.0, i_Year: 1)
    sem1.AddCourse(i_course: Course(i_Name: "Linear", i_Grade: "A", i_Credits: 6, i_Year: 1, i_Parent: sem1, i_CountTowardsGPA: true))
    sem1.AddCourse(i_course: Course(i_Name: "Calc", i_Grade: "B+", i_Credits: 6, i_Year: 1, i_Parent: sem1, i_CountTowardsGPA: true))
     sem1.AddCourse(i_course: Course(i_Name: "Intro", i_Grade: "A+", i_Credits: 5, i_Year: 1, i_Parent: sem1, i_CountTowardsGPA: true))
     sem1.AddCourse(i_course: Course(i_Name: "Discrete", i_Grade: "B-", i_Credits: 6, i_Year: 1, i_Parent: sem1, i_CountTowardsGPA: true))
    sem1.CalculateSemesterAverage()
    
     let sem2 = Semester(i_Semester: Sem.B, i_GPA: 0.0, i_Credits: 0.0, i_Year: 2)
    sem2.AddCourse(i_course: Course(i_Name: "Linear2", i_Grade: "C", i_Credits: 6, i_Year: 2, i_Parent: sem2, i_CountTowardsGPA: true))
    sem2.AddCourse(i_course: Course(i_Name: "Calc2", i_Grade: "A-", i_Credits: 6, i_Year: 2, i_Parent: sem2, i_CountTowardsGPA: true))
    sem2.AddCourse(i_course: Course(i_Name: "Advanced", i_Grade: "A", i_Credits: 5, i_Year: 2, i_Parent: sem2, i_CountTowardsGPA: true))
    sem2.AddCourse(i_course: Course(i_Name: "Data Structures", i_Grade: "D+", i_Credits: 6, i_Year: 2, i_Parent: sem2, i_CountTowardsGPA: true))
    sem2.CalculateSemesterAverage()
    AllSemesters.append(sem1)
    AllSemesters.append(sem2)
}
