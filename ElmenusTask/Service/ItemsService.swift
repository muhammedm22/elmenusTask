//
//  ItemsService.swift
//  ElmenusTask
//
//  Created by Apple on 11/2/19.
//  Copyright © 2019 Muhammmed. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class ItemsService
{
    let itemsURL = kBaseURL + "items/"
    
    func getItems(tagName:String  , completion :@escaping (_ tags:[Item]) -> ())
    {
        
        if Reachability.isConnectedToNetwork()
        {
            getItemsFromAPIWith(tagName : tagName, completion:  { (tags) in
                completion(tags)
            })
        }else
        {
            getItemsFromLocalWith(tagName: tagName, completion: { (tags) in
                completion(tags)
            })
        }

    }
    
    private func getItemsFromAPIWith(tagName:String ,  completion :@escaping (_ tags:[Item]) -> ())
    {
        let url = itemsURL + tagName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        Alamofire.request(url, method: .get, parameters: nil , encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completion([])
                    return
                }
                let items = try? JSONDecoder().decode(ItemsResponse.self, from: data)
                completion(items?.items ?? [] )
                self.setDataForItems(tags: items?.items ?? [])
            case .failure(_):
                completion([])
            }
        })
    }
    
    
    func setDataForItems(tags:[Item])
    {
        let realm = try! Realm()
        
        for tag in tags
        {
            try! realm.write {
                realm.add(tag)
            }
        }
    }
    
func getItemsFromLocalWith(tagName:String , completion :@escaping (_ tags:[Item]) -> ()) {
        let realm = try! Realm()
        let items = realm.objects(Item.self).filter("name contains '\(tagName)'")
        var array = [Item]()
        for item in items
        {
            array.append(item)
        }
        completion(array)
        
    }
    
}
