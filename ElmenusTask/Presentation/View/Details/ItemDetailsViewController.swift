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
    var currentItem:Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setData()
        setTitleToNavigationController()
        
    }
    
    private func setData()
    {
        self.itemImage.sd_setImage(with: URL(string:currentItem.photoURL), completed: nil)
        self.itemImage.hero.id = currentItem.name
        self.itemName.text = currentItem.itemDescription

    }
    


}

extension ItemDetailsViewController : UIScrollViewDelegate
{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        if y > 10
        {
            hideMainImage()
            setImageToNavigationBar()
        }else{
            showMainImage()
            setTitleToNavigationController()
        }
        self.itemImage.layoutIfNeeded()
    }
    
    
    private func hideMainImage()
    {
        UIView.transition(with: itemImage, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.itemImage.isHidden = true
        }, completion: { _ in
            self.imageViewHeight.constant = 0
        })
    }
    
    private func showMainImage()
    {
        UIView.transition(with: itemImage, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.itemImage.isHidden = false
        }, completion: { _ in
            self.imageViewHeight.constant = 220
        })
    }
    
    private func setImageToNavigationBar()
    {
        let container = UIView()
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.sd_setImage(with: URL(string: self.currentItem.photoURL), completed: nil)
        imageView.hero.id = self.currentItem.name
        container.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: imageView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: container, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: container, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40).isActive = true
        NSLayoutConstraint(item: imageView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40).isActive = true
        
        self.navigationItem.titleView = container
        
      
        
  
    }
    
    private func setTitleToNavigationController()
    {
        let label = UILabel()
        label.text = self.currentItem.name
        self.navigationItem.titleView = label
    }
  
    
}
