//
//  ViewController.swift
//  MyAverageUSA
//
//  Created by Jonathan  Wesfield on 2017-07-03.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//



/** 
 TODO: 
 
 1) new semester ui #
 2) weights picture #
 3) launch screen #
 4) firebase 
 5) gpa weights save button #
 6) course ring ui #
 7) course info UI - save button bigger - further from cancel #
 8) course info - picker in proper place #
 9) GPA label bigger - course view #
 
 
 
 **/


import AppsFlyerLib
import UIKit
import Firebase
import FirebaseDatabase
//import UICircularProgressRing

class MainMenuVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    /** IBOutlets **/
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var semesterPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet var newSemesterView: UIViewX!
    
    @IBOutlet weak var totalGPALabel: UILabel!
    
    /** Data Members **/
    
    private var customPickerSemesters = SemesterPickerView()
    private var customPickerYears = YearPickerView()
    private var semesters = [Sem.A , Sem.B, Sem.C]
    private var years = [1 , 2, 3 , 4]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SemesterListToDictionary()
    
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.yearPicker.dataSource = customPickerYears
        self.yearPicker.delegate = customPickerYears
        self.semesterPicker.dataSource = customPickerSemesters
        self.semesterPicker.delegate = customPickerSemesters
        //setTotalGPA()
        //tableView.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        setTotalGPA()
         tableView.reloadData()
        
    }
    
    
    private func setTotalGPA(){
        
        var GPA = 0.0
        var totalCredits = 0.0
        
        for i in AllSemesters{
            for j in i.Courses{
                if(j.CountTowardsGPA == true){
                    GPA +=  Double(GPAWeights.GetGPAWeight(i_LetterGrade: j.Grade)) * j.Credits
                    totalCredits += j.Credits
                }
            }
        }
        
        GPA /= totalCredits
        
        GPA =  GPA.isNaN ? 0.0 : GPA
        
        self.totalGPALabel.text = "Total GPA : \(GPA.roundToDecimal(2))"
    }
    
    
    
    @IBAction func newSemesterButtonPressed(_ sender: Any) {
        tempView.bounds = UIScreen.main.bounds
        tempView.center = view.center
        tempView.layer.backgroundColor = UIColor.darkGray.cgColor
        tempView.alpha = 0.8
        self.view.addSubview(tempView)
        
        self.newSemesterView.center = view.center
        self.newSemesterView.transform  = CGAffineTransform(scaleX: 0.8, y: 1.2)
        view.addSubview(self.newSemesterView)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations:{ self.newSemesterView.transform = .identity   })
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let selectedYear = years[self.yearPicker.selectedRow(inComponent: 0)]
        let selectedSemester = semesters[self.semesterPicker.selectedRow(inComponent: 0)]
        let newSemester = Semester(i_Semester: selectedSemester, i_GPA: 0.0, i_Credits: 0.0, i_Year: selectedYear)
        //  let newSem = Semester(i_semester: selectedSemester, i_average: 0, i_credits: 0, i_year: 4)
        
        AppsFlyerTracker.shared().trackEvent("new_semester", withValue: "")
        
        AllSemesters.append(newSemester)
         tableView.reloadData()
         UserDefaults.standard.set(SemesterListToDictionary(), forKey: "SemesterDictionary")
        self.newSemesterView.removeFromSuperview() // close view
        tempView.removeFromSuperview()
        
        
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        newSemesterView.removeFromSuperview()
        tempView.removeFromSuperview()
    }
    
    /** Table View **/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllSemesters.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SemesterCell", for: indexPath) as? SemesterCell {
            
            let newSemester = AllSemesters[indexPath.row]
            cell.configureCell(i_Semester: newSemester)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = AllSemesters[indexPath.row]
        performSegue(withIdentifier: "courseListVC", sender: course)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AllSemesters.remove(at: indexPath.row)
            UserDefaults.standard.set(SemesterListToDictionary(), forKey: "SemesterDictionary")
            tableView.reloadData()
            setTotalGPA()
        } else if editingStyle == .insert {
            
        }
    }

    /** Segue **/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "courseListVC" ) {
            let upcoming = segue.destination as! CourseListVC
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let sem = AllSemesters[(indexPath.row)]
                 upcoming.CurrentSemester = sem
                upcoming.CurrentSemesterIndex = indexPath.row 
                
            }
        }
    }
    
}
