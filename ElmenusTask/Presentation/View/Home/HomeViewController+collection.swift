//
//  HomeViewController+collection.swift
//  ElmenusTask
//
//  Created by Apple on 11/2/19.
//  Copyright © 2019 Muhammmed. All rights reserved.
//

import Foundation
import UIKit
import Hero


extension HomeViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    // Collection view datasource methods
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tagsCollection
        {
            let cell = self.tagsCollection.dequeueReusableCell(withReuseIdentifier: "tagCollectionViewCell", for: indexPath ) as! TagCollectionViewCell
            let tag = tags[indexPath.row]
            cell.setUpCellWith(tag:tag)
            return cell
            
        }else if collectionView == itemsCollection
        {
            let cell = self.itemsCollection.dequeueReusableCell(withReuseIdentifier: "itemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
           // let item = items[indexPath.row]
            //cell.itemImage.sd_setImage(with: URL(string:item.photoURL!), completed: nil)
            //cell.itemTitle.text = item.name ?? ""
            cell.itemImage.image = UIImage(named:"AdobeStock_105994137-1024x680")
            cell.itemImage.hero.id = "image1"
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagsCollection
        {
            return tags.count
        }else if collectionView == itemsCollection
        {
           // return items.count
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == tagsCollection
        {
            if indexPath.row  == tags.count - pagingBeforeItems
            {
                homePresenter.getTags()
            }
        }
    }
    
    
    // MARK : - Collection view delegate methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tagsCollection
        {
            homePresenter.getItemsFor(tag: tags[indexPath.row])

        }else if collectionView == itemsCollection
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ItemDetailsViewController") as! ItemDetailsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    // MARK: - Collection view delegate flowlayout methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tagsCollection
        {
           return CGSize(width: tagsCollection.frame.width / 3 , height: tagsCollection.frame.width / 3 )
            
        }else if collectionView == itemsCollection
        {
            return CGSize(width: itemsCollection.frame.width , height: 98)

        }
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}


