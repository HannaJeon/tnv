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
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
        
        cell.userLabel.text = post.user
        cell.createdAtLabel.text = formatter.string(from: post.createdAt)
        cell.messageLabel.text = post.message
        cell.likedLabel.text = "\(post.likedCount!) 명이 좋아합니다"
        cell.mainImage.image = UIImage(data: post.imageData)
        
        return cell
    }

    @IBAction func logoutButton(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "로그아웃 하시겠습니까?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "NO", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "YES", style: UIAlertActionStyle.default, handler: { (_) in
            self.saveLogoutStatus()
            let vc: LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! LoginViewController
            self.present(vc, animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveLogoutStatus() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "login")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dvc = storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
        let post = posts[indexPath.row]
        
        dvc.image = UIImage(data: post.imageData)!
        dvc.text = post.message!
        dvc.count = post.likedCount
        
        self.navigationController?.pushViewController(dvc, animated: true)
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
