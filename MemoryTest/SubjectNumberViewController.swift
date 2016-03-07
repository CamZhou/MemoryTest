//
//  SubjectNumberViewController.swift
//  MemoryTest
//
//  Created by Cam on 2/2/16.
//
//

import UIKit

class SubjectNumberViewController: UIViewController {
    
    let dataManager = DataManager()
    let question = String()
    
    override func viewDidLoad() {
        if let subNum = getSubjectNumber() {
            subjectNumberTextField.text = subNum.stringValue
        }
        dataManager.clearCurrentProblem()
        print("did clear current")
    }
    
    override func viewWillDisappear(animated: Bool) {
        storeSubjectNumber()
        print("did store subject num")
        dataManager.prepareForStart()
        print("did store current time")
    }
    
    func getSubjectNumber() -> NSNumber? {
        return dataManager.getSubjectNum()
    }
    
    func storeSubjectNumber() {
        if let subNum = Int(subjectNumberTextField.text!) {
            dataManager.storeSubjectNum(NSNumber(integer: subNum))
        }
    }

    @IBOutlet weak var subjectNumberTextField: UITextField!
    
    
}
