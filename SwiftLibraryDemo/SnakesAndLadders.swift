//
//  SnakesAndLadders.swift
//  SwiftLibraryDemo
//
//  Created by langyue on 16/5/9.
//  Copyright © 2016年 langyue. All rights reserved.
//

import UIKit


protocol SnakesAndLaddersDelegate {
    func gameDidStart(game:String)
    func game(game:String,didStartNewTurnWithDiceRoll diceRoll:Int)
}


typealias funcBlock = (result:String) ->Void



class SnakesAndLadders: NSObject {
    
    
    
    var delegate:SnakesAndLaddersDelegate?
    
    
    override init() {
        super.init()
        print("创建了SnakesAndLadders类");
    }
    
    
    func userLogin(name:String,pass:String,result:funcBlock){
        print("name = \(name),pass = \(pass)")
        result(result: "姓名：\(name),密码：******* -->登陆成功")
    }
    
    
    
    func play(game:String,diceRoll:Int){
        delegate?.gameDidStart(game)
        delegate?.game(game, didStartNewTurnWithDiceRoll: diceRoll)
    }
    

}
