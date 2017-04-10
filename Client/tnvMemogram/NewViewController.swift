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
    var selectedImage = UIImage()
//    var returnedImageId = String()
    
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
        formatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        let url = "http://localhost:8000/api/upload"
        
        Alamofire.upload(multipartFormData: {
            multipartFormData in
            
            if let imageData = UIImageJPEGRepresentation(self.selectedImage, 0.6) {
                multipartFormData.append(imageData, withName: "image", fileName: "file.png", mimeType: "image/png")
            }
        }, to: url) { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                print("success")
                upload.responseJSON(completionHandler: { response in
                    if let ok = response.result.value {
                        let defaults = UserDefaults.standard
                        let username = defaults.object(forKey: "username") as! String
                        
                        if let dict = ok as? [String:String] {
                            let post = Post(id: "fefefe", user: username, photoId: dict["ok"]!, createdAt: Date(), isLiked: false, likedCount: 0, message: "", imageData: Data())
                            let parameters: [String:Any] = [
                                "id" : post.id,
                                "user" : post.user,
                                "photoId" : post.photoId,
                                "createdAt" : formatter.string(from: self.datePicker.date),
                                "isLiked" : post.isLiked,
                                "likeCount" : post.likedCount,
                                "message" : self.newMessage.text
                            ]
                            
                            Alamofire.request("http://localhost:8000/api/post", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
                                
                            }
                        }
                    }
                })
            case .failure(let error):
                print("failed")
                print(error)
            }
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
        guard let picked = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        self.selectedImage = picked
        self.dismiss(animated: true, completion: nil)
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
