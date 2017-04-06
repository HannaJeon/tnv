//
//  Feeds.swift
//  TnvMemogram
//
//  Created by Mac on 2017. 4. 5..
//  Copyright © 2017년 Hanna. All rights reserved.
//

import UIKit
import Alamofire

class FeedsView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    var imageData = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        Post.postsFromBundle { (posts) in
            self.posts = posts
            self.tableView.reloadData()
            print(posts)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: .none, queue: OperationQueue.main) { [weak self] _ in self?.tableView.reloadData()
        }
        Post.postsFromBundle { (posts) in
            self.posts = posts
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeLineView", for: indexPath) as! PostsCell
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let post = posts[indexPath.row]
        
//        var image: Data = UIImagePNGRepresentation(post.imageData)
        
        cell.userLabel.text = post.user
        cell.createdAtLabel.text = formatter.string(from: post.createdAt)
        cell.messageLabel.text = post.message
        cell.likedLabel.text = "\(post.likedCount!) 명이 좋아합니다"
        cell.mainImage.image = UIImage(data: post.imageData)
        
        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


//extension Feeds: UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("aAAAAAAAAAAAAA")
//        return posts.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeLineView", for: indexPath) as! PostsCell
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        
//        let post = posts[indexPath.row]
//        
//        cell.userLabel.text = post.user
//        cell.createdAtLabel.text = formatter.string(from: post.createdAt)
//        cell.messageLabel.text = post.message
//        cell.likedLabel.text = "\(post.likedCount!) 명이 좋아합니다"
//        
//        print("BBBBBBBBBBBB")
//        return cell
//    }
//}
