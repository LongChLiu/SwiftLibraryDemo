//
//  MainViewController.swift
//  SwiftLibraryDemo
//
//  Created by langyue on 16/5/9.
//  Copyright © 2016年 langyue. All rights reserved.
//

import UIKit



import Alamofire
import SwiftyJSON
import Kingfisher
import SnapKit




class TabCell: UITableViewCell {
    
    var imgView:UIImageView!
    var titleLabel:UILabel!
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        imgView = UIImageView()
        self.contentView.addSubview(imgView)
        
        
        titleLabel = UILabel()
        self.contentView.addSubview(titleLabel)
        
        
        imgView.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(self.snp_centerY)
            make.width.height.equalTo(50)
        }
        
        
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(imgView.snp_right).offset(10)
            make.centerY.equalTo(self.snp_centerY)
            make.right.equalTo(-10)
            make.height.equalTo(40)
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}


class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var tabView:UITableView!
    let URLString = "https://api.douban.com/v2/book/search"
    var booksArr = [Book]()
    
    
    var butityGirlArr = ["http://www.yisinet.com/cache/upload/user/2014/09/28/Usr1HNh8iumo3pg/2015/03/18/1000/2/1/o_19gldoddi1gla11b01agur4hjsel.jpg",
                         "http://www.yisinet.com/cache/upload/user/2014/09/28/Usr1HNh8iumo3pg/2015/03/18/1000/2/1/o_19gldoddirn658spd11t8i10tlp.jpg",
                         "http://www.2298.com/UploadStorage/136629/aa7556f31df142b0a32a896b60a27ba6.jpg",
                         "http://image83.360doc.com/DownloadImg/2015/03/1408/51134067_75.jpg",
                         "http://u.thsi.cn/2013/05/18/8043736860b03048302d9.jpg",
                         "http://www.51modo.cc/upload/kindeditor/image/20150115/20150115191351_40811.jpg",
                         "http://imgsrc.baidu.com/forum/w%3D580/sign=593ed1fe014f78f0800b9afb49300a83/b89a448b4710b9126a2fb954c1fdfc039345223d.jpg",
                         "http://img.taopic.com/uploads/allimg/140320/235013-14032020220911.jpg",
                         "http://image.cnsc8.com/tupian_201409/Big_Pic/ep4YcRxdw6.jpg",
                         "http://image.cnsc8.com/tupian_201406/Big_Pic/9jONGfLhtt.jpg",
                         "http://d.3987.com/siwa_150427/desk_001.jpg",
                         "http://image83.360doc.com/DownloadImg/2015/02/2614/50517340_1.jpg",
                         "http://www.taopic.com/uploads/allimg/110603/49-1106031U33667.jpg",
                         "http://www.psahz.com/uploads/allimg/140423/2010316013-0.jpg",
                         "http://pic73.nipic.com/file/20150725/17961491_130317862000_2.jpg",
                         "http://4493bz.1985t.com/uploads/allimg/140822/4-140R2133932.jpg",
                         "http://s13.sinaimg.cn/mw690/0066WCQPgy6WRHNVPsMec&690",
                         "http://image83.360doc.com/DownloadImg/2015/02/2614/50517340_2.jpg",
                         "http://ww2.sinaimg.cn/large/0069jKBBgw1exkcfrxnnzj31cg26kto2.jpg",
                         "http://img.taopic.com/uploads/allimg/130906/318756-130Z60T21226.jpg"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tabView = UITableView()
        tabView.registerClass(TabCell.self, forCellReuseIdentifier: "cell0")
        tabView.delegate = self
        tabView.dataSource = self
        self.view.addSubview(tabView)
        tabView.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        
        self.getData()
        
        
        // Do any additional setup after loading the view.
    }

    
    
    
    
    func getData(){
        
    
        Alamofire.request(.GET, URLString,parameters: ["tag":"Swift","count":20]).validate().responseJSON { (resp) in
            
        
            if let error = resp.result.error{
                
                print(error)
                
                
            }else if let value = resp.result.value{
                
                let jsonArray = JSON(value)["books"].array
                for json in jsonArray! {
                    
                    let book = Book()
                    book.bookTitle = json["title"].string ?? ""
                    book.bookSubTitle = json["subtitle"].string ?? ""
                    book.bookImage = json["image"].string ?? ""
                    self.booksArr.append(book)
                    
                }
                self.tabView.reloadData()
            }
            
        }
        
        
        
        
        
        
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell0", forIndexPath: indexPath) as! TabCell
        let book = self.booksArr[indexPath.row]
        
        cell.titleLabel.text = book.bookTitle
        
        //cell.titleLabel.text = book.bookSubTitle
        cell.imgView.kf_setImageWithURL(NSURL(string: book.bookImage)!  ?? NSURL())
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.booksArr.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let book = self.booksArr[indexPath.row]
        
        //let detailVC = storyboard?.instantiateViewControllerWithIdentifier("detail") as! DetailViewController
        
        
        let detailVC = DetailViewController()
        detailVC.book = book
        detailVC.imageString = self.butityGirlArr[indexPath.row]
        presentViewController(detailVC, animated: true, completion: nil)
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
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





class Book: NSObject {
    
    var bookTitle:String = ""
    var bookSubTitle:String = ""
    var bookImage:String = ""
    
}




