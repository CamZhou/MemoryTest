//
//  CorrelationCalc.swift
//  MemoryTest
//
//  Created by Cam on 3/1/16.
//
//

import UIKit

class CorrelationCalc: NSObject {
    var arr1 = [Int]()
    var arr2 = [Int]()
    
    var dict = [String:Int]()
    
    init(a1: [Int], a2: [Int]) {
        arr1 = a1
        arr2 = a2
    }
    
    func correlate() -> NSNumber {
        return correlate(0, p2: 0)
    }
    
    func correlate(p1: Int, p2: Int) -> NSNumber {
        if (p1 >= arr1.count || p2 >= arr2.count) {
            return 0
        }
        
        if (arr1[p1] == arr2[p2]) {
            let key = String(p1+1) + " " + String(p2+1)
            if let cor = dict[key] {
                return cor
            } else {
                return 5 + correlateHelp(p1+1, p2: p2+1)
            }
        }
        
        let opt1 = correlateHelp(p1+1, p2: p2) - 1
        let opt2 = correlateHelp(p1, p2: p2+1) - 1
        
        return max(opt1, opt2)
    }
    
    func correlateHelp(p1: Int, p2: Int) -> Int {
        let key = String(p1) + " " + String(p2)
        if let cor = dict[key] {
            return cor
        } else {
            let cor = correlate(p1, p2: p2).integerValue
            dict[key] = cor
            return cor
        }
    }
    
}
