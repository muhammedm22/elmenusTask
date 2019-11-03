//
//  ItemDetailsViewController.swift
//  ElmenusTask
//
//  Created by Apple on 11/2/19.
//  Copyright © 2019 Muhammmed. All rights reserved.
//

import UIKit
import SDWebImage
import Hero

class ItemDetailsViewController: UIViewController {
    
    // MARK : - OUtlets
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    
    // MARK : - Properties
  //  var currentItem:Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setData()
        
    }
    
    private func setData()
    {
      //  self.itemImage.sd_setImage(with: URL(string:currentItem.photoURL!), completed: nil)
        //self.itemImage.heroID = currentItem.name
      //  self.itemName.text = currentItem.itemDescription
        self.itemImage.image = UIImage(named:"AdobeStock_105994137-1024x680")
        self.itemImage.hero.id = "image1"
    }
    


}

extension ItemDetailsViewController : UIScrollViewDelegate
{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        if y > 10
        {
            UIView.transition(with: itemImage, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.itemImage.isHidden = true
            }, completion: { _ in
                self.imageViewHeight.constant = 0
            })

        }else{
      
            
            UIView.transition(with: itemImage, duration: 0.5, options: .transitionCrossDissolve, animations: {
                  self.itemImage.isHidden = false
            }, completion: { _ in
                self.imageViewHeight.constant = 220
            })

            
        }
        self.itemImage.layoutIfNeeded()
    }
  
    
}
