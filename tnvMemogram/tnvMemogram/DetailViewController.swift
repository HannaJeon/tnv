//
//  DetailViewController.swift
//  TnvMemogram
//
//  Created by hoemoon on 07/04/2017.
//  Copyright © 2017 Hanna. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var image = UIImage()
    var text = String()
    var count = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        draw()

        // Do any additional setup after loading the view.
    }
    
    func draw() {
        imageView.image = image
        textView.text = text
        likeCount.text = String(count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchHeart(_ sender: Any) {
        likeButton.setImage(#imageLiteral(resourceName: "whiteHeart"), for: .normal)
        likeButton.setImage(#imageLiteral(resourceName: "blackHeart"), for: .selected)
        self.count += 1
        
        likeButton.isSelected = !likeButton.isSelected
        draw()
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
