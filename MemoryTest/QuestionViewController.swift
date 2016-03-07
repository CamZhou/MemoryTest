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
    
    override func viewDidLoad() {
        setup()
        displayQuestion()
    }
    
    private func setup() {
        
        answerButton.hidden = true
        let timer = NSTimer(timeInterval: NSTimeInterval(Constant.WAIT_TIME), target: self, selector: "answer", userInfo: nil, repeats: false)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        setupProgressBar()
    }
    
    private func setupProgressBar() {
        progressBar.progress = dataManager.progress()
    }
    
    private func displayQuestion() {
        switch dataManager.getCurrentType() {
        case 0:
            questionView.text = "Try to remember as many numbers in sequence as possible:\n\n" + generateNumberString()
            questionView.font = UIFont.systemFontOfSize(40)
            break
        case 1:
            break
        default:
            break
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
