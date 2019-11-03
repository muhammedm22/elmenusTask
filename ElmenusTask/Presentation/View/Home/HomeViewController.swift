//
//  ViewController.swift
//  ElmenusTask
//
//  Created by Apple on 10/29/19.
//  Copyright © 2019 Muhammmed. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {

    // MARK : - Outlets
    @IBOutlet weak var tagsCollection: UICollectionView!
    @IBOutlet weak var itemsCollection: UICollectionView!
    @IBOutlet weak var tagsCollectionHeight: NSLayoutConstraint!
    // MARK : - Properties
    var tags = [Tag]()
    var items = [Item]()
    var homePresenter:HomePresenter!
    let pagingBeforeItems = 4


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpUI()
        self.homePresenter = HomePresenter(view: self)
        loadTags()
        
    }
    
    private func loadTags()
    {
        homePresenter.getTags()
    }
    
    private func setUpUI()
    {
        self.title = "Home"
    }


}


extension HomeViewController : HomeViewDelegate
{
    func fetchTagsSuccessWith(tags: [Tag]) {
        self.tags += tags
        self.tagsCollection.reloadData()
    }
    
    func fetchItemsSucessWith(items:[Item])
    {
        self.items = items
        self.itemsCollection.reloadData()
    }
    
    func startLoadingIndicator() {
        print("start loading")
        
    }
    func stopLoadIndicator() {
        print("end loading")
        
    }
}

