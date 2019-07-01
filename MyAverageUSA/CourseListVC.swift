//
//  CourseListVC.swift
//  MyAverageUSA
//
//  Created by Jonathan  Wesfield on 2017-07-03.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import UIKit
import AppsFlyerLib

class CourseListVC: UIViewController  , UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate   {

    
    /** IBOutlets **/
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var GPALabel: UILabel!
    
     /** New Course **/

    @IBOutlet weak var countTowardsGPASwitch: UISwitch!
    @IBOutlet weak var CourseViewTopLabel: UILabel!
    @IBOutlet weak var nameField: UITextFieldX!
    @IBOutlet var newCourseView: UIViewX!
    @IBOutlet weak var creditsField: UITextFieldX!
    
    /** Data Members **/
    
    public var CurrentSemester : Semester!
    public var CurrentSemesterIndex : Int!
    private var selectedCourseToEditIndex : Int!
    private var isEditingCourse = false
    private var selectedCourseToEdit : Course!
    private var CoursePicker = CoursePickerView()
    
    @IBOutlet weak var gradePicker: UIPickerView!
    
    private var grades = ["A+" ,  "A" , "A-" , "B+" ,  "B" , "B-" , "C+" ,  "C" , "C-", "D+" , "D" , "D-" , "F"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.nameField.delegate = self
        self.creditsField.delegate = self
        
        gradePicker.delegate = CoursePicker
        gradePicker.dataSource = CoursePicker
        
        self.nameLabel.text = "Year \(CurrentSemester.Year) / Semester \(CurrentSemester.SemesterLetter)"
        self.GPALabel.text = "GPA : \(CurrentSemester.GPA.roundToDecimal(2))"
        
        
    
        
    }

  
    @IBAction func newCourseButtonPressed(_ sender: Any) {
        
        self.CourseViewTopLabel.text = "Add New Course"
        self.nameField.text = ""
        self.creditsField.text = ""
        self.AddViews()
        
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        var inputName = ""
        var inputCredits = 0.0
        let countForGPA = self.countTowardsGPASwitch.isOn
        let selectedGrade = grades[self.gradePicker.selectedRow(inComponent: 0)]
        
        /* NameField */
        if let currentName = self.nameField.text, nameField.text != "" {
            
            inputName = currentName;
            
            /* Credits Field */
            if let currentCreditsString = self.creditsField.text {
                if let currentCreditsNumber = Double(currentCreditsString){
                    inputCredits = currentCreditsNumber
                } else {
                    self.present(self.getAlert(i_alertNumber: 3), animated: true, completion: nil)
                    return
                }
            } else {
                self.present(self.getAlert(i_alertNumber: 3), animated: true, completion: nil)
                return
            }
            
        } else {
            self.present(self.getAlert(i_alertNumber: 1), animated: true, completion: nil)
            return
        }
        
        
        if(isEditingCourse == false ){
            
            let newCourse = Course(i_Name: inputName, i_Grade: selectedGrade, i_Credits: inputCredits, i_Year: self.CurrentSemester.Year, i_Parent: CurrentSemester, i_CountTowardsGPA: countForGPA)
        
            self.CurrentSemester.AddCourse(i_course: newCourse)
            
            AppsFlyerTracker.shared().trackEvent("new_course", withValue: "new_course")
            
            // AllSemesters[self.CurrentSemesterIndex].AddCourse(i_course: newCourse)
            // UserDefaults.standard.set(SemesterListToDictionary(), forKey: "data2")
            tableView.reloadData()
            
            
        } else {
           
            
            self.selectedCourseToEdit.Name = inputName
            self.selectedCourseToEdit.Grade = selectedGrade
            self.selectedCourseToEdit.Credits = inputCredits
            self.selectedCourseToEdit.CountTowardsGPA = countForGPA
            
//            AllSemesters[CurrentSemesterIndex].Courses[selectedCourseToEditIndex].Grade = selectedGrade
//            AllSemesters[CurrentSemesterIndex].Courses[selectedCourseToEditIndex].Name = inputName
//            AllSemesters[CurrentSemesterIndex].Courses[selectedCourseToEditIndex].Credits = inputCredits
//            AllSemesters[CurrentSemesterIndex].Courses[selectedCourseToEditIndex].CountTowardsGPA = countForGPA
            
            //UserDefaults.standard.set(SemesterListToDictionary(), forKey: "data2")
            
            isEditingCourse = false
            
            tableView.reloadData()
            
        }
        
        self.CurrentSemester.CalculateSemesterAverage()
        AllSemesters[CurrentSemesterIndex].CalculateSemesterAverage()
        self.GPALabel.text = "GPA : \(CurrentSemester.GPA.roundToDecimal(2))"
         UserDefaults.standard.set(SemesterListToDictionary(), forKey: "SemesterDictionary")
        tableView.reloadData()
        newCourseView.removeFromSuperview()
        tempView.removeFromSuperview()
    
    }
    
  
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        newCourseView.removeFromSuperview()
        tempView.removeFromSuperview()
    }
    
    
    /** Table View **/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.CurrentSemester.Courses.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as? CourseCell {
            
            let currentCourse = self.CurrentSemester.Courses[indexPath.row]
            cell.configureCell(i_Course: currentCourse)
            
            return cell
            
        } else {
            
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCourseToEdit = self.CurrentSemester.Courses[indexPath.row]
        self.selectedCourseToEditIndex = indexPath.row
        self.isEditingCourse = true
        self.CourseViewTopLabel.text = "Course Info"
        self.nameField.text = selectedCourseToEdit.Name
        self.countTowardsGPASwitch.isOn = selectedCourseToEdit.CountTowardsGPA
        
        //TODO:
        var index = 0
        var indexOfLetter = 0
        for i in grades{
            if(i == selectedCourseToEdit.Grade){
                index =  indexOfLetter
                break
            }
            indexOfLetter += 1
        }
        
        self.gradePicker.selectRow(index, inComponent: 0, animated: true)
        
        
        self.creditsField.text = "\(selectedCourseToEdit.Credits)"
        self.AddViews()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            self.CurrentSemester.RemoveCourse(i_index: indexPath.row)
            CurrentSemester.CalculateSemesterAverage()
            // TODO: Delete from all_semesters
            //  AllSemesters[CurrentSemesterIndex].RemoveCourse(i_index: indexPath.row)
            self.GPALabel.text = "GPA : \(CurrentSemester.GPA.roundToDecimal(2))"
             UserDefaults.standard.set(SemesterListToDictionary(), forKey: "SemesterDictionary")
            tableView.reloadData()
            
        }
    }

    public func AddViews (){
        
        tempView.bounds = UIScreen.main.bounds
        tempView.center = view.center
        tempView.layer.backgroundColor = UIColor.darkGray.cgColor
        tempView.alpha = 0.8
        self.view.addSubview(tempView)
        self.newCourseView.center = view.center
        self.newCourseView.transform  = CGAffineTransform(scaleX: 0.8, y: 1.2)
        view.addSubview(self.newCourseView)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations:{ self.newCourseView.transform = .identity   })
        
        
    }
    
    
    
    private func getAlert (i_alertNumber : Int) -> UIAlertController{
        let alert1 = UIAlertController(title: "Invalid Name", message: "Please Enter a Valid Course Name", preferredStyle: .alert)
        
        alert1.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        
        let alert2 = UIAlertController(title: "Invalid Grade", message: "Please Enter a Valid Grade", preferredStyle: .alert)
        
        alert2.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        
        let alert3 = UIAlertController(title: "Invalid Credits", message: "Please Enter a Valid Credits Amount", preferredStyle: .alert)
        
        alert3.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        
        if(i_alertNumber == 1){
            
            return alert1
            
        } else if (i_alertNumber == 2){
            
            return alert2
            
        } else {
            
            return alert3
        }
    }
    
    /** Text Field functions **/
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
