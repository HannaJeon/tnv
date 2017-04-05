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
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButton(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "글 작성을 취소하겠습니까?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        requestPost()
        self.dismiss(animated: true, completion: nil)
    }
    
    func requestPost() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let aa = Post()
        let parameters: [String:Any] = [
            "id" : aa.id,
            "user" : aa.user,
            "photoId" : aa.photoId,
            "createdAt" : formatter.string(from: datePicker.date),
            "isLiked" : aa.isLiked,
            "likeCount" : aa.likedCount,
            "message" : newMessage.text
        ]
        
        Alamofire.request("http://localhost:8000/api/post", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in }
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
