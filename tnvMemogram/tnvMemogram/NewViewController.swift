//
//  NewViewController.swift
//  TnvMemogram
//
//  Created by 김재정 on 2017. 4. 4..
//  Copyright © 2017년 Hanna. All rights reserved.
//

import UIKit
import Alamofire

class NewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var newMessage: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButton(_ sender: Any) {
        requestPost()
        print(newMessage.text)
    }
    
    func requestPost() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let aa = Post(id: "aa", user: "aa", photoId: "aa", createdAt: Date(), isLiked: true, likedCount: 1, message: "aa")
        let parameters: [String:Any] = [
            "id" : aa.id,
            "user" : aa.user,
            "photoId" : aa.photoId,
            "createdAt" : formatter.string(from: aa.createdAt),
            "isLiked" : aa.isLiked,
            "likeCount" : aa.likedCount,
            "message" : aa.message
        ]
        
        Alamofire.request("http://localhost:8000/api/post", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
//            print(response)
        }
    }
    
    fileprivate func presentImagePickerController() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        self.present(pickerController, animated: true, completion: nil)
    }
    @IBAction func pickButton(_ sender: Any) {
        self.presentImagePickerController()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
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
