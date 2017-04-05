//
//  TabBarController.swift
//  TnvMemogram
//
//  Created by Mac on 2017. 4. 5..
//  Copyright © 2017년 Hanna. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    let feedsView = FeedsView()
    let newVew = NewViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabPlus = FeedsView()
        let tabPlusBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "plus"), selectedImage: nil)
        
        tabPlus.tabBarItem = tabPlusBarItem
        
        self.viewControllers = [tabPlus]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
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
