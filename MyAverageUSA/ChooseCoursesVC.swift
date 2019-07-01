//
//  ChooseCoursesVC.swift
//  MyAverageUSA
//
//  Created by Jonathan  Wesfield on 2017-07-09.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import UIKit


struct courseCheck {
    var isChecked : Bool
    var course : Course
    var index : Int
    
    mutating func setState (state : Bool){
        self.isChecked = state
    }
}

func getCourseCheck (course : Course) -> courseCheck {
    for i in CheckedCoursesArray {
        //name might not be good enough
        if(i.course.Name ==  course.Name){
            return i
        }
    }
    return CheckedCoursesArray[0]
}

var CheckedCoursesArray = [courseCheck]()


class ChooseCoursesVC: UIViewController  , UITableViewDelegate , UITableViewDataSource {

    /** IBOutlets **/
    
    @IBOutlet weak var yearSegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    /** DataMembers **/
    
    private var currentCourses = [courseCheck]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAllSemestersCopy()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        CheckedCoursesArray.removeAll()
        
        var index = 0
        
        for i in AllSemestersCopy {
            for j in i.Courses{
                CheckedCoursesArray.append(courseCheck(isChecked: false, course: j, index: index))
                index += 1
            }
        }
        
        currentCourses = CheckedCoursesArray
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        

    }
    
    
    public func setUpAllSemestersCopy(){
        AllSemestersCopy.removeAll()
        for i in AllSemesters{
            let semesterCopy = Semester(i_Semester: i.SemesterLetter, i_GPA: i.GPA, i_Credits: i.Credits, i_Year: i.Year)
            for j in i.Courses {
                let courseCopy = Course(i_Name: j.Name, i_Grade: j.Grade, i_Credits: j.Credits, i_Year: j.Year, i_Parent: j.ParentSemester, i_CountTowardsGPA: j.CountTowardsGPA)
                semesterCopy.AddCourse(i_course: courseCopy)
            }
            AllSemestersCopy.append(semesterCopy)
        }
    }
    
    
    @IBAction func yearSegmentPressed(_ sender: Any) {
        
        self.currentCourses.removeAll()
        if(self.yearSegment.selectedSegmentIndex == 0){
            self.currentCourses = CheckedCoursesArray
        } else {
            let currentYear = self.yearSegment.selectedSegmentIndex
            for i in CheckedCoursesArray {
                if(i.course.Year == currentYear){
                    self.currentCourses.append(i)
                }
            }
        }
        
        tableView.reloadData()
        
    }
    

    @IBAction func nextButtonPressed(_ sender: Any) {
        
    }
    
    
    
    
    
    
    /** Table View **/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCheckCell", for: indexPath) as? CourseCheckCell {
            
            let course = currentCourses[indexPath.row]
            cell.configureCell(NewClass: course)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
    
    
    

}
