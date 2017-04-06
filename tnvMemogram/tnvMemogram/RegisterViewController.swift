//
//  RegisterViewController.swift
//  TnvMemogram
//
//  Created by 김재정 on 2017. 4. 5..
//  Copyright © 2017년 Hanna. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    

    @IBOutlet weak var emTextField: UITextField!
    
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var logoImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestUser() {

        let url = "http://localhost:8000/api/user/login"
        let parameters: [String: Any] = [
            "email": String(describing: emTextField.text!),
            "password": String(describing: pwTextField.text!)
        ]
        print(parameters)
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            var temp = response.result.value as! [String:Any]
            if let b = temp["message"] as? Bool {
                print(2, b)
            }
            /*
            if response["message"] == "0" {
             
                let alert = UIAlertController(title: "Alert", message: "다시 입력하세요", preferredStyle: UIAlertControllerStyle.alert)
                
                self.present(alert, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "Alert", message: "가입이 완료되었습니다.", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: { (_) in
                    let vc = UIStoryboard(name:"FeedsView", bundle:nil).instantiateViewController(withIdentifier: "mainPosts") as? FeedsView
                    self.present(vc!, animated: true, completion: nil)
                }))
                
                self.present(alert, animated: true, completion: nil)
            }*/
        }

    }
    
    @IBAction func accountCreated(_ sender: Any) {
        requestUser()
    }
    
    @IBAction func alreadyRegistered(_ sender: Any) {
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
