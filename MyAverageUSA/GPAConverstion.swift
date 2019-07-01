//
//  GPAConverstion.swift
//  MyAverageUSA
//
//  Created by Jonathan  Wesfield on 2017-07-03.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import Foundation


public class GPAConversion {
  
    
    /** Data Members **/
    
    private var m_APlus : Float!
    private var m_A : Float!
    private var m_AMinus : Float!
    private var m_BPlus : Float!
    private var m_B : Float!
    private var m_BMinus : Float!
    private var m_CPlus : Float!
    private var m_C : Float!
    private var m_CMinus : Float!
    private var m_DPlus : Float!
    private var m_D : Float!
    private var m_DMinus : Float!
    private var m_F : Float!
   
    var APlus: Float {
        get { return self.m_APlus }
        set { self.m_APlus  = newValue }
    }
    var A: Float {
        get { return self.m_A }
        set { self.m_A  = newValue }
    }
    var AMinus: Float {
        get { return self.m_AMinus }
        set { self.m_AMinus  = newValue }
    }
    
    var BPlus: Float {
        get { return self.m_BPlus }
         set { self.m_BPlus  = newValue }
    }
    var B: Float {
        get { return self.m_B }
         set { self.m_B  = newValue }
    }
    var BMinus: Float {
        get { return self.m_BMinus }
         set { self.m_BMinus  = newValue }
    }
    
    var CPlus: Float {
        get { return self.m_CPlus }
         set { self.m_CPlus  = newValue }
    }
    var C: Float {
        get { return self.m_C}
        set { self.m_C  = newValue }
    }
    var CMinus: Float {
        get { return self.m_CMinus }
          set { self.m_CMinus  = newValue }
    }
    
    var DPlus: Float {
        get { return self.m_DPlus }
         set { self.m_DPlus  = newValue }
    }
    var D: Float {
        get { return self.m_D }
         set { self.m_D  = newValue }
    }
    var DMinus: Float {
        get { return self.m_DMinus }
         set { self.m_DMinus  = newValue }
    }
    
    var F: Float {
        get { return self.m_F }
        set { self.m_F  = newValue }
    }
    
    
    init(i_APlus : Float , i_A : Float , i_AMinus : Float , i_BPlus : Float , i_B : Float , i_BMinus : Float , i_CPlus : Float , i_C : Float , i_CMinus : Float , i_DPlus : Float , i_D : Float , i_DMinus : Float , i_F : Float ) {
        
        
        m_APlus = i_APlus;
        m_A = i_A;
        m_AMinus = i_AMinus;
        
        m_BPlus = i_BPlus;
        m_B = i_B;
        m_BMinus = i_BMinus;
        
        m_CPlus = i_CPlus;
        m_C = i_C;
        m_CMinus = i_CMinus;
        
        m_APlus = i_DPlus;
        m_A = i_D;
        m_AMinus = i_DMinus;
        
        m_F = i_F;
        
    }
    
    init(standard : String ){
        
        if(standard == "standard")
        {
            SetStandards()
        }
    
    }
    
    
    public func SetNewMapping(i_APlus : Float , i_A : Float , i_AMinus : Float , i_BPlus : Float , i_B : Float , i_BMinus : Float , i_CPlus : Float , i_C : Float , i_CMinus : Float , i_DPlus : Float , i_D : Float , i_DMinus : Float , i_F : Float){
        
        
        m_APlus = i_APlus;
        m_A = i_A;
        m_AMinus = i_AMinus;
        
        m_BPlus = i_BPlus;
        m_B = i_B;
        m_BMinus = i_BMinus;
        
        m_CPlus = i_CPlus;
        m_C = i_C;
        m_CMinus = i_CMinus;
        
        m_APlus = i_DPlus;
        m_A = i_D;
        m_AMinus = i_DMinus;
        
        m_F = i_F;
    }
    
    
    public func SetStandards(){
        
        
        m_APlus = 4.00
        m_A = 4.00
        m_AMinus = 3.67
        
        m_BPlus = 3.33
        m_B = 3.00
        m_BMinus = 2.67
        
        m_CPlus = 2.33
        m_C = 2.00
        m_CMinus = 1.67
        
        m_DPlus = 1.33
        m_D = 1.00
        m_DMinus = 0.67
        
        m_F = 0.00
    }
    
    
    public func SetDataFromJSON(i_Data : String){
        
    }
    
    public func GetGPAWeight(i_LetterGrade : String) -> Float {
        
        
        switch (i_LetterGrade) {
        case "A+":
            return self.m_APlus;
        case "A":
            return self.m_A;
        case "A-":
            return self.m_AMinus;
        case "B+":
            return self.m_BPlus;
        case "B":
            return self.m_B;
        case "B-":
            return self.m_BMinus;
        case "C+":
            return self.m_CPlus;
        case "C":
            return self.m_C;
        case "C-":
            return self.m_CMinus;
        case "D+":
            return self.m_DPlus;
        case "D":
            return self.m_D;
        case "D-":
            return self.m_DMinus;
        default:
            return 0.0;
        }
        
    }
    
    
    public func GPAWeightsToDictionary() -> Dictionary<String , Float>{
        
        var GPADictionary = Dictionary<String , Float>()
        
        GPADictionary["APlus"] = self.m_APlus
        GPADictionary["A"] = self.m_A
        GPADictionary["AMinus"] = self.m_AMinus
        
        GPADictionary["BPlus"] = self.m_BPlus
        GPADictionary["B"] = self.m_B
        GPADictionary["BMinus"] = self.m_BMinus
        
        GPADictionary["CPlus"] = self.m_CPlus
        GPADictionary["C"] = self.m_C
        GPADictionary["CMinus"] = self.m_CMinus
        
        GPADictionary["DPlus"] = self.m_DPlus
        GPADictionary["D"] = self.m_D
        GPADictionary["DMinus"] = self.m_DMinus
        
        GPADictionary["F"] = self.m_F
        
        
        // print(GPADictionary)
        
        return GPADictionary
    }
    
    public static func DictionaryToGPAConversions(i_GPADictionary : Dictionary<String , Float>) -> GPAConversion {
        
        let newGPAWeights = GPAConversion(standard: "standard")
    
        if let APlusWeight = i_GPADictionary["APlus"]{
            newGPAWeights.APlus = APlusWeight;
        }
        if let AWeight = i_GPADictionary["A"]{
            newGPAWeights.A = AWeight;
        }
        if let AMinusWeight = i_GPADictionary["AMinus"]{
            newGPAWeights.AMinus = AMinusWeight;
        }
        
        if let BPlusWeight = i_GPADictionary["BPlus"]{
            newGPAWeights.BPlus = BPlusWeight;
        }
        if let BWeight = i_GPADictionary["B"]{
            newGPAWeights.B = BWeight;
        }
        if let BMinusWeight = i_GPADictionary["BMinus"]{
            newGPAWeights.BMinus = BMinusWeight;
        }
        
        if let CPlusWeight = i_GPADictionary["CPlus"]{
            newGPAWeights.CPlus = CPlusWeight;
        }
        if let CWeight = i_GPADictionary["C"]{
            newGPAWeights.C = CWeight;
        }
        if let CMinusWeight = i_GPADictionary["CMinus"]{
            newGPAWeights.CMinus = CMinusWeight;
        }
        
        if let DPlusWeight = i_GPADictionary["DPlus"]{
            newGPAWeights.DPlus = DPlusWeight;
        }
        if let DWeight = i_GPADictionary["D"]{
            newGPAWeights.D = DWeight;
        }
        if let DMinusWeight = i_GPADictionary["DMinus"]{
            newGPAWeights.DMinus = DMinusWeight;
        }
        
        if let FWeight = i_GPADictionary["F"]{
            newGPAWeights.F = FWeight;
        }
        
    
        return newGPAWeights
    }
    
    
}
