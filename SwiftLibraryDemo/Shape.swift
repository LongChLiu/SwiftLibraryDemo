//
//  Shape.swift
//  SwiftLibraryDemo
//
//  Created by langyue on 16/5/9.
//  Copyright © 2016年 langyue. All rights reserved.
//

import UIKit

class Shape: NSObject {

    
    
    var numberOfSides :Int = 0
    var name :String
    
    
    init(name:String) {
        
        self.name = name
        
    }
    
    
    
    
    func simpleDescription()->String{
        return "A shape with \(numberOfSides) sides.";
    }
    
    
}
