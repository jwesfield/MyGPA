//
//  GPAWeightsVC.swift
//  MyAverageUSA
//
//  Created by Jonathan  Wesfield on 2017-07-06.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import UIKit
import AppsFlyerLib

class GPAWeightsVC: UIViewController  , UITextFieldDelegate , UINavigationControllerDelegate {

    
    
    /** IBOutlets **/
    
    @IBOutlet weak var APlusField: UITextFieldX!
    @IBOutlet weak var AField: UITextFieldX!
    @IBOutlet weak var AMinusField: UITextFieldX!
    
    @IBOutlet weak var BPlusField: UITextFieldX!
    @IBOutlet weak var BField: UITextFieldX!
    @IBOutlet weak var BMinusField: UITextFieldX!
    
    @IBOutlet weak var CPlusField: UITextFieldX!
    @IBOutlet weak var CField: UITextFieldX!
    @IBOutlet weak var CMinusField: UITextFieldX!
    
    @IBOutlet weak var DPlusField: UITextFieldX!
    @IBOutlet weak var DField: UITextFieldX!
    @IBOutlet weak var DMinusField: UITextFieldX!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDelegates()
        setUpTextFields()
        
        // GPAWeights.GPAWeightsToDictionary()
        
    }
    
    
    private func setUpDelegates(){
        
        APlusField.delegate = self
        AField.delegate = self
        AMinusField.delegate = self
        BPlusField.delegate = self
        BField.delegate = self
        BMinusField.delegate = self
        CPlusField.delegate = self
        CField.delegate = self
        CMinusField.delegate = self
        DPlusField.delegate = self
        DField.delegate = self
        DMinusField.delegate = self
        
        APlusField.keyboardType = .decimalPad
        AField.keyboardType = .decimalPad
        AMinusField.keyboardType = .decimalPad
        BPlusField.keyboardType = .decimalPad
        BField.keyboardType = .decimalPad
        BMinusField.keyboardType = .decimalPad
        CPlusField.keyboardType = .decimalPad
        CField.keyboardType = .decimalPad
        CMinusField.keyboardType = .decimalPad
        DPlusField.keyboardType = .decimalPad
        DField.keyboardType = .decimalPad
        DMinusField.keyboardType = .decimalPad
     
        
    }
    
    
    private func setUpTextFields(){
        
        APlusField.text = "\(GPAWeights.APlus)"
        AField.text = "\(GPAWeights.A)"
        AMinusField.text = "\(GPAWeights.AMinus)"
        
        BPlusField.text = "\(GPAWeights.BPlus)"
        BField.text = "\(GPAWeights.B)"
        BMinusField.text = "\(GPAWeights.BMinus)"
        
        CPlusField.text = "\(GPAWeights.CPlus)"
        CField.text = "\(GPAWeights.C)"
        CMinusField.text = "\(GPAWeights.CMinus)"
        
        DPlusField.text = "\(GPAWeights.DPlus)"
        DField.text = "\(GPAWeights.D)"
        DMinusField.text = "\(GPAWeights.DMinus)"
        
    }
    

    @IBAction func saveButtonPressed(_ sender: Any) {
        
        
         if let weightTextAPlus = APlusField.text ,
            let weightAPlus = Float(weightTextAPlus) ,
            let weightTextA = AField.text ,
            let weightA = Float(weightTextA) ,
            let weightTextAMinus = AMinusField.text ,
            let weightAMinus = Float(weightTextAMinus),
            let weightTextBPlus = BPlusField.text ,
            let weightBPlus = Float(weightTextBPlus) ,
            let weightTextB = BField.text ,
            let weightB = Float(weightTextB) ,
            let weightTextBMinus = BMinusField.text ,
            let weightBMinus = Float(weightTextBMinus),
            let weightTextCPlus = CPlusField.text ,
            let weightCPlus = Float(weightTextCPlus) ,
            let weightTextC = CField.text ,
            let weightC = Float(weightTextC) ,
            let weightTextCMinus = CMinusField.text ,
            let weightCMinus = Float(weightTextCMinus),
            let weightTextDPlus = DPlusField.text ,
            let weightDPlus = Float(weightTextDPlus) ,
            let weightTextD = DField.text ,
            let weightD = Float(weightTextD) ,
            let weightTextDMinus = DMinusField.text ,
            let weightDMinus = Float(weightTextDMinus) {
            
            GPAWeights.APlus = weightAPlus
            GPAWeights.A = weightA
            GPAWeights.AMinus = weightAMinus
            GPAWeights.BPlus = weightBPlus
            GPAWeights.B = weightB
            GPAWeights.BMinus = weightBMinus
            GPAWeights.CPlus = weightCPlus
            GPAWeights.C = weightC
            GPAWeights.CMinus = weightCMinus
            GPAWeights.DPlus = weightDPlus
            GPAWeights.D = weightD
            GPAWeights.DMinus = weightDMinus
            
            //   performSegue(withIdentifier: "ToMainMenuFromGPAWeights", sender: nil)
        
            
            AppsFlyerTracker.shared().trackEvent("gpa_weights_changed", withValue: "weights_changed")
            UserDefaults.standard.setValue(GPAWeights.GPAWeightsToDictionary(), forKeyPath: "GPADictionary")
            self.navigationController?.popToRootViewController(animated: true)
            
        } else {
        
            let alert = UIAlertController(title: "Invalid Input", message: "Please Enter a Valid GPA Weights", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func resetToStandardPressed(_ sender: Any) {
        
        GPAWeights.SetStandards()
        UserDefaults.standard.setValue(GPAWeights.GPAWeightsToDictionary(), forKeyPath: "GPADictionary")
        self.navigationController?.popToRootViewController(animated: true)
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
