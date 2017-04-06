//
//  RegisterViewController.swift
//  TnvMemogram
//
//  Created by 김재정 on 2017. 4. 5..
//  Copyright © 2017년 Hanna. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var pwInput: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerReq(callback: @escaping (_ isUser: Bool) -> Void) {
        
        var isUser = Bool()
        
        let url = URL(string: "http://localhost:8000/api/user/register")
        
        let parameters: Parameters = [
            "email" : self.emailInput.text!,
            "password" : self.pwInput.text!
        ]
        
        Alamofire.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            if let res = response.result.value as? [String : Any] {
                
                if let value = res["message"] as? Bool {
                    isUser = value
                }
            }
            callback(isUser)
        }
    }
    
    func loginReq(callback: @escaping (_ isUser: Bool) -> Void) {
        
        var isUser = Bool()
        
        let url = URL(string: "http://localhost:8000/api/user/login")
        
        let parameters: Parameters = [
            "email" : self.emailInput.text!,
            "password" : self.pwInput.text!
        ]
        
        Alamofire.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            if let res = response.result.value as? [String : Any] {
                if let value = res["message"] as? Bool {
                    isUser = value
                }
            }
            print(isUser)
            callback(isUser)
        }
    }
    
    @IBAction func accountCreated(_ sender: Any) {
        registerReq { (isUser) in
            if self.emailInput.text == "" || self.pwInput.text == "" {
                let alert = UIAlertController(title: "Alert", message: "이메일과 패스워드를 입력해 주세요", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
            
            if isUser == true {
                let alert = UIAlertController(title: "Alert", message: "회원가입이 완료되었습니다.", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Alert", message: "이미 가입된 사용자입니다.", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        loginReq { (isUser) in
//            print(isUser)
            if isUser == true {
                self.saveLoginStatus()
                let vc : FeedsView = self.storyboard?.instantiateViewController(withIdentifier: "mainPosts") as! FeedsView
                let navigationController = UINavigationController(rootViewController: vc)
                self.present(navigationController, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Alert", message: "가입된 사용자가 없습니다. 회원가입 하시겠습니까?", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "NO", style: UIAlertActionStyle.cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "YES", style: UIAlertActionStyle.default, handler: { (_) in
                    self.accountCreated((Any).self)
                    self.saveLoginStatus()
                    let vc : FeedsView = self.storyboard?.instantiateViewController(withIdentifier: "mainPosts") as! FeedsView
                    let navigationController = UINavigationController(rootViewController: vc)
                    self.present(navigationController, animated: true, completion: nil)
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    func saveLoginStatus() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "login")
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
