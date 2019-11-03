//
//  TagCollectionViewCell.swift
//  ElmenusTask
//
//  Created by Apple on 10/30/19.
//  Copyright © 2019 Muhammmed. All rights reserved.
//

import UIKit
import Hero

class TagCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tagImage:UIImageView!
    @IBOutlet weak var tagTitle:UILabel!
    
    
    func setUpCellWith(tag:Tag)
    {
        self.tagTitle.text = tag.tagName ?? ""
        self.tagImage.sd_setImage(with: URL(string : tag.photoURL ?? ""), completed: nil)
    }
    
}
