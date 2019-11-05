//
//  HomePresenter.swift
//  ElmenusTask
//
//  Created by Apple on 10/31/19.
//  Copyright © 2019 Muhammmed. All rights reserved.
//

import Foundation

// Home view delegate protocol to handle data from presenter to view
protocol HomeViewDelegate : AnyObject {
    func startLoadingIndicator()
    func stopLoadIndicator()
    func fetchTagsSuccessWith(tags:[Tag])
    func loadMoreTagsSuccess(tags:[Tag])
    func fetchItemsSucessWith(items:[Item])
}

class HomePresenter {
    
    private weak var homeView:HomeViewDelegate?
    var pageNumber = 1
    init(view:HomeViewDelegate)
    {
        self.homeView = view
    }
    
    
    // MARK: - Get tags
    func getTags()
    {
        self.homeView?.startLoadingIndicator()
        TagsService().getTags(page: pageNumber, completion: {(tags ) in
            self.homeView?.stopLoadIndicator()
            self.homeView?.fetchTagsSuccessWith(tags: tags )
        })
        self.pageNumber += 1
    }
    
    func loadMoreTags()
    {
        self.homeView?.startLoadingIndicator()
        TagsService().loadMoreTags(page: pageNumber, completion: {(tags) in
            self.homeView?.stopLoadIndicator()
            self.homeView?.loadMoreTagsSuccess(tags: tags )
        })
        self.pageNumber += 1

    }
    
    func getItemsFor(tag:Tag)
    {
        self.homeView?.startLoadingIndicator()
        ItemsService().getItems(tagName: tag.tagName  , completion: { (items) in
            self.homeView?.stopLoadIndicator()
            self.homeView?.fetchItemsSucessWith(items: items)
            
        })
        
    }
    
    
}
