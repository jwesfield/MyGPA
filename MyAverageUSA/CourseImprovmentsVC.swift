//
//  CourseImprovmentsVC.swift
//  MyAverageUSA
//
//  Created by Jonathan  Wesfield on 2017-07-09.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import UIKit
import UICircularProgressRing
import AppsFlyerLib

var AllSemestersCopy = [Semester]()

class CourseImprovmentsVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var totalImprovmentLabel: UILabel!
    @IBOutlet weak var yearImprovmentLabel: UILabel!
    @IBOutlet weak var semesterImprovmentLabel: UILabel!
    
    
    @IBOutlet weak var yearStackView: UIStackView!
    
    @IBOutlet weak var semesterStackView: UIStackView!
    
    @IBOutlet weak var totalBottomLabel: UILabel!
    
    @IBOutlet weak var yearBottomLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var semesterBottomLabel: UILabel!
    
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var semesterLabel: UILabel!
    
    private var selectedCourses = [Course]()
    private var ImprovmentData : Improments!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppsFlyerTracker.shared().trackEvent("course_improvment_opened", withValue: "improvment")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        self.navigationItem.title = "Simulator"
    
        for i in CheckedCoursesArray {
            if(i.isChecked == true) {
                selectedCourses.append(i.course)
            }
        }
        
        if(selectedCourses.count < 1){
            let alert1 = UIAlertController(title: "No Courses Selected", message: "Please go back and select courses to improve.", preferredStyle: .alert)
            
            alert1.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            self.present(alert1, animated: true, completion: nil)
            return
        }
        
         self.ImprovmentData = Improments(i_Courses: self.selectedCourses)
        
        if(!self.ImprovmentData.IsOneYear){
            self.semesterStackView.isHidden = true
            self.yearLabel.isHidden = true
            self.yearBottomLabel.isHidden = true
            self.yearImprovmentLabel.isHidden = true
            
        }
        if(!self.ImprovmentData.IsOneSemester){
            self.yearStackView.isHidden = true
            self.semesterLabel.isHidden = true
            self.semesterBottomLabel.isHidden = true
            self.semesterImprovmentLabel.isHidden = true
            
        }
        
        
        loadValuesToView()
        

    }
    
    @IBAction func stepperPressed(_ sender: Any) {
        //loadValuesToView()
    }
    
    
    public func loadValuesToView(){
        
        /* Total */
        let totalGPA = self.ImprovmentData.TotalGPA.roundToDecimal(2)
        let initialGPA = ImprovmentData.InitialTotalGPA.roundToDecimal(2)
        self.totalLabel.text = "\(totalGPA)"
        if(totalGPA > initialGPA){
            self.totalImprovmentLabel.textColor = UIColor.green
            self.totalImprovmentLabel.text = "+ \((totalGPA - initialGPA).roundToDecimal(2))"
        } else if (totalGPA < initialGPA){
            self.totalImprovmentLabel.textColor = UIColor.red
            self.totalImprovmentLabel.text = "- \((initialGPA - totalGPA).roundToDecimal(2))"
        } else {
            self.totalImprovmentLabel.textColor = UIColor.black
            self.totalImprovmentLabel.text = "\(totalGPA)"
        }
        
       /* Year */
        
        if(self.ImprovmentData.IsOneYear == true){
            let totalYearGPA = self.ImprovmentData.YearGPA.roundToDecimal(2)
            let initialYearGPA = ImprovmentData.InitialYearGPA.roundToDecimal(2)
            self.yearLabel.text = "\(totalYearGPA)"
            self.yearBottomLabel.text = "Year \(self.ImprovmentData.CurrentYear)"
            if(totalYearGPA > initialYearGPA){
                self.yearImprovmentLabel.textColor = UIColor.green
                self.yearImprovmentLabel.text = "+ \((totalYearGPA - initialYearGPA).roundToDecimal(2))"
            } else if (totalYearGPA < initialYearGPA){
                self.yearImprovmentLabel.textColor = UIColor.red
                self.yearImprovmentLabel.text = "- \((initialYearGPA - totalYearGPA).roundToDecimal(2))"
            } else {
                self.yearImprovmentLabel.textColor = UIColor.black
                self.yearImprovmentLabel.text = "\(totalYearGPA)"
            }
        }
        
        /* Semester */

        if(self.ImprovmentData.IsOneSemester == true){
            let totalSemesterGPA = self.ImprovmentData.SemesterGPA.roundToDecimal(2)
            let initialSemesterGPA = ImprovmentData.InitialSemesterGPA.roundToDecimal(2)
            self.semesterLabel.text = "\(totalSemesterGPA)"
            self.semesterBottomLabel.text = "Semester \(self.ImprovmentData.CurrentSemester.SemesterLetter)"
            if( totalSemesterGPA > initialSemesterGPA){
                self.semesterImprovmentLabel.textColor = UIColor.green
                self.semesterImprovmentLabel.text = "+ \((totalSemesterGPA - initialSemesterGPA).roundToDecimal(2))"
            } else if ( totalSemesterGPA < initialSemesterGPA){
                self.semesterImprovmentLabel.textColor = UIColor.red
                self.semesterImprovmentLabel.text = "- \((initialSemesterGPA -  totalSemesterGPA).roundToDecimal(2))"
            } else {
                self.semesterImprovmentLabel.textColor = UIColor.black
                self.semesterImprovmentLabel.text = "\(totalSemesterGPA)"
            }
        }
    }

    
    
    /** Table View **/
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CourseImprovmentCell", for: indexPath) as? CourseImpromentsCell {
            
            let currentCourse =  selectedCourses[indexPath.row]
            cell.tag = indexPath.row
            cell.configureCell(i_Course: currentCourse  , i_Data: ImprovmentData, i_ParentView: self )
            
            return cell
            
        } else {
            
            return UITableViewCell()
        }
        
        
    }
    
    
}
