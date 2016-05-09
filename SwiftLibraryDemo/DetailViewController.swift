//
//  DetailViewController.swift
//  SwiftLibraryDemo
//
//  Created by langyue on 16/5/9.
//  Copyright © 2016年 langyue. All rights reserved.
//

import UIKit
import Alamofire




class DetailViewController: UIViewController {
    
    
    
    
    var progressLabel: UILabel!
    var imageView: UIImageView!
    
    
    
    
    
    var book: Book!
    var imageString:String = ""
    var imagePath = ""
    
    
    

    func createUI(){
        
        
        imageView = UIImageView()
        progressLabel = UILabel()
        self.view.addSubview(imageView)
        self.view.addSubview(progressLabel)
        
        
        
        imageView.snp_makeConstraints { (make) in
            make.left.right.left.right.equalTo(0)
        }
        
        
        progressLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp_centerX)
            make.centerY.equalTo(self.view.snp_centerY)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.createUI()
        
        
        self.downloadImage()
        
        

        // Do any additional setup after loading the view.
    }

    
    
    func downloadImage(){
        
        
        
        
        
        
        Alamofire.download(.GET, self.imageString) { (url, response) -> NSURL in
            
            
            self.imagePath = NSHomeDirectory() + "/" + (response.suggestedFilename ?? "01.png")
            let fileManager = NSFileManager.defaultManager()
            if fileManager.fileExistsAtPath(self.imagePath){
                try! fileManager.removeItemAtPath(self.imagePath)
            }
            return NSURL(fileURLWithPath: self.imagePath)
            
        }.progress { (readBytes, totalReadBytes, totalBytes) in
            
            let progress = Int(Double(totalReadBytes) / Double(totalBytes) * 100)
            dispatch_async(dispatch_get_main_queue(), {
                self.progressLabel.text = "\(progress)%"
            })
            
            
        }.response(queue: dispatch_get_main_queue()) { (_, _, _, error) in
            
            if let error = error {
                print(error)
            }else{
                self.progressLabel.hidden = true
                self.imageView.image = UIImage(contentsOfFile: self.imagePath)
            }
            
        }
        
        
    }
    
    
    
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
