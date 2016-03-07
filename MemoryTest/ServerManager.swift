//
//  ServerManager.swift
//  MemoryTest
//
//  Created by Cam on 2/23/16.
//
//

import UIKit
import Parse

class ServerManager: NSObject {
    override init() {
        super.init()
        
    }
    
    static func uploadInfo() {
        let dataManager = DataManager()
        let memoResult = PFObject(className: Constant.ServerObject)
        memoResult[Constant.SUBJECT] = dataManager.getSubjectNum()
        memoResult[Constant.START_TIME] = dataManager.getStartTime()
        memoResult[Constant.CORRELATION] = dataManager.getCorrelation().description
        memoResult[Constant.SCORE] = dataManager.getScore()
        memoResult.saveInBackground();
    }

}
