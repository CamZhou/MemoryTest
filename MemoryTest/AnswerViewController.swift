//
//  AnswerViewController.swift
//  MemoryTest
//
//  Created by Cam on 2/2/16.
//
//

import UIKit

class AnswerViewController: UIViewController, UITextViewDelegate{
    
    @IBOutlet weak var questionView: UITextView!
    
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    let dataManager = DataManager()
    
    var question = [Int]()
    var answer = [Int]()
    
    override func viewDidLoad() {
        setup()
    }
    
    override func viewDidAppear(animated: Bool) {
        dataManager.incrementProblem()
        print(question)
    }
    
    func setup() {
        finishButton.hidden = true
        moreButton.hidden = true
        questionView.textColor = UIColor.lightGrayColor()
        questionView.text = "Type all the numbers you remember in sequence."
        questionView.font = UIFont.systemFontOfSize(40)
        questionView.delegate = self
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type all the numbers you remember in sequence."
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    
    @IBAction func nextQuestion(sender: UIButton) {
        recordAnswer()
        if dataManager.hasMoreProblems() {
            moreButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        } else {
            calculateScore()
            uploadData()
            finishButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        }
    }
    
    func recordAnswer(){
        let string = questionView.text
        for char in string.characters {
            if let digit = Int(String(char)) {
                answer.append(digit)
            }
        }
        correlate()
    }
    
    func correlate() {
        let correlateHelp = CorrelationCalc(a1: question, a2: answer)
        dataManager.storeCorrelation(correlateHelp.correlate())
    }
    
    func calculateScore() {
        var sum = 0
        for cor in dataManager.getCorrelation() {
            sum += cor.integerValue
        }
        
        dataManager.storeScore(sum)
    }
    
    func uploadData() {
        ServerManager.uploadInfo()
    }
    
    func recordAnswer(answer: Int) {
        switch answer {
        case 0: break
        case 1: break
        case 2: break
        case 3: break
        case 4: break
        default: break
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
