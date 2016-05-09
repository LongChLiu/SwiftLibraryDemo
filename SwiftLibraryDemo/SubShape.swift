//
//  SubShape.swift
//  SwiftLibraryDemo
//
//  Created by langyue on 16/5/9.
//  Copyright © 2016年 langyue. All rights reserved.
//

import UIKit


protocol ExampleProtocol {
    
    var simpleDescription:String{
        get
    }
    
    mutating func adjust()
    mutating func myFunction(name:String,age:Int)
    
}



enum Rank :Int {
    case Ace = 1
    case Two
    case Jack
}


enum ServerResponse {
    case Result(String,String)
    case Error(String)
}




class SubShape: Shape {
    
    var rankStyle:Rank
    var sideLength:Double
    
    init(sideLength:Double,name:String){
        
        self.rankStyle = Rank.Ace
        self.sideLength = sideLength;
        super.init(name: name)
        
        numberOfSides = 10000;
    }
    
    
    
    
    var perimeter:Double{
        
        get{
            return 3 * sideLength
        }
        set{
            sideLength = newValue / 3.0
        }
        
    }
    
    func area()->Double{
        return sideLength * sideLength
    }
    
    
    
    override func simpleDescription() -> String {
        return "A SubShape withsides of length \(sideLength)"
    }
    
    
    let success = ServerResponse.Result("6:00 am", "8:09 pm")
    let failure = ServerResponse.Error("Out of cheese")
    
    
    func adjust() {
        print("adjust()")
    }
    
    
    func myFunction(name:String,age:Int){
        print("name = \(name),age = \(age)")
    }
    
    
    
    
    

}
