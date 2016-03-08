//
//  DataManager.swift
//  MemoryTest
//
//  Created by Cam on 2/2/16.
//
//

import UIKit

class DataManager: NSObject {
    var path = String()
    var dict = NSMutableDictionary()
    
    override init() {
        super.init()
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as! NSString
        path = documentsDirectory.stringByAppendingPathComponent(Constant.PLIST_NAME + ".plist")
        
        let fileManager = NSFileManager.defaultManager()
        
        //check if file exists
        if(!fileManager.fileExistsAtPath(path)) {
            // If it doesn't, copy it from the default file in the Bundle
            if let bundlePath = NSBundle.mainBundle().pathForResource(Constant.PLIST_NAME, ofType: "plist") {
                
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
                print("Bundle Result.plist file is --> \(resultDictionary?.description)")
                do {
                    try fileManager.copyItemAtPath(bundlePath, toPath: path)
                } catch {
                    
                }
                print("copy")
            } else {
                print("GameData.plist not found. Please, make sure it is part of the bundle.")
            }
        } else {
            print("GameData.plist already exits at path.")
            // use this to delete file from documents directory
            //fileManager.removeItemAtPath(path, error: nil)
        }

        // path = NSBundle.mainBundle().pathForResource(Constant.PLIST_NAME, ofType: "plist")!
        dict = NSMutableDictionary(contentsOfFile: path)!
    }
    
    private func getValue(key: String) -> AnyObject? {
        return dict.valueForKey(key)
    }
    
    private func storeValue(key: String, obj: AnyObject) {
        dict.setObject(obj, forKey: key)
        print("ready to save")
        print(dict)
        print(NSDictionary(contentsOfFile: path)!)
        if dict.writeToFile(path, atomically: false) {
            print("SAVED")
        }
        print(NSDictionary(contentsOfFile: path)!)
    }
    
    func getSubjectNum() -> NSNumber? {
        return getValue(Constant.SUBJECT) as! NSNumber?
    }
    
    func storeSubjectNum(subjetNumber: NSNumber) {
        storeValue(Constant.SUBJECT, obj: subjetNumber)
    }
    
    func prepareForStart() {
        storeValue(Constant.CORRELATION, obj: Array<NSNumber>())
        storeValue(Constant.START_TIME, obj: NSDate(timeIntervalSinceNow: 0.0))
    }
    
    func getStartTime() -> NSDate {
        return getValue(Constant.START_TIME) as! NSDate
    }
    
    func getCurrentProblem() -> NSNumber? {
        return getValue(Constant.CURRENT_PROBLEM) as! NSNumber?
    }
    
    func clearCurrentProblem() {
        storeValue(Constant.CURRENT_PROBLEM, obj: NSNumber(integer: 0))
    }
    
    func hasMoreProblems() -> Bool {
        return getCurrentProblem()!.integerValue < Constant.NUM_OF_QUESTIONS
    }
    
    func progress() -> Float {
        return getCurrentProblem()!.floatValue / Float(Constant.NUM_OF_QUESTIONS)
    }
    
    func incrementProblem() {
        storeValue(Constant.CURRENT_PROBLEM, obj: NSNumber(integer: (getCurrentProblem()!.integerValue + 1)))
    }
    
    func randomDigit() -> Int {
        return Int(arc4random()) % 10
    }
    
    func getCurrentType() -> Int {
        return getCurrentProblem()!.integerValue * Constant.NUM_OF_QUESTION_TYPES / Constant.NUM_OF_QUESTIONS
    }
    
    func getCorrelation() -> Array<NSNumber> {
        return getValue(Constant.CORRELATION) as! Array<NSNumber>
    }
    
    func storeCorrelation(correlation: NSNumber) {
        var correlations = getCorrelation()
        correlations.append(correlation)
        storeValue(Constant.CORRELATION, obj: correlations)
    }
    
    func storeScore(score: NSNumber) {
        storeValue(Constant.SCORE, obj: score)
    }
    
    func getScore() -> NSNumber {
        return getValue(Constant.SCORE) as! NSNumber
    }
    
}
