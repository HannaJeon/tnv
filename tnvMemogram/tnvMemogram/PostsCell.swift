//
//  PostsTableViewCell.swift
//  tnvMemogram
//
//  Created by Mac on 2017. 3. 31..
//  Copyright © 2017년 Hanna. All rights reserved.
//

import UIKit

class PostsCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var likedLabel: UILabel!
    @IBOutlet weak var likedButton: UIButton!

    @IBAction func likedpressButton(_ sender: UIButton) {

        likedButton.setImage(#imageLiteral(resourceName: "whiteHeart"), for: .normal)
        likedButton.setImage(#imageLiteral(resourceName: "blackHeart"), for: .selected)

        likedButton.isSelected = !likedButton.isSelected
    }
}
