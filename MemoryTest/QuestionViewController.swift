//
//  QuestionViewController.swift
//  MemoryTest
//
//  Created by Cam on 2/2/16.
//
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var questionView: UITextView!
    
    @IBOutlet weak var answerButton: UIButton!
    
    let dataManager = DataManager()
    
    var question = [Int]()
    
    var didStart = Bool()
    
    override func viewDidLoad() {
        setup()
        displayQuestion()
    }
    
    private func setup() {
        didStart = false
        answerButton.hidden = true
        setupProgressBar()
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        self.questionView.addGestureRecognizer(tap)
    }
    
    private func setupProgressBar() {
        progressBar.progress = dataManager.progress()
    }
    
    private func displayQuestion() {
        switch dataManager.getCurrentType() {
        case 0:
            questionView.text = "Try to remember as many numbers in sequence as possible in " + String(Constant.WAIT_TIME) + " seconds:\n\nTouch to begin."
            questionView.font = UIFont.systemFontOfSize(40)
            break
        case 1:
            break
        default:
            break
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touched()
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            touched()
        }
    }
    
    func touched() {
        if (!didStart) {
            didStart = true
            questionView.text = "Start memorizing: \n\n" + generateNumberString()
            questionView.font = UIFont.systemFontOfSize(60)
            let timer = NSTimer(timeInterval: NSTimeInterval(Constant.WAIT_TIME), target: self, selector: "answer", userInfo: nil, repeats: false)
            NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        }
    }
    
    private func generateNumberString() -> String {
        var str = ""
        for _ in 1...Constant.NUM_OF_DIGITS {
            let digit = dataManager.randomDigit()
            str += String(digit)
            str += " "
            question.append(digit)
        }
        return str
    }
    
    
    func answer(){
        answerButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "answer" {
            let answerViewController = segue.destinationViewController as! AnswerViewController
            answerViewController.question = question
        }
    }
}
