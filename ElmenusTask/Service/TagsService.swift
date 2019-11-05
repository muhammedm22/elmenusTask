//
//  TagsService.swift
//  ElmenusTask
//
//  Created by Apple on 10/31/19.
//  Copyright © 2019 Muhammmed. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class TagsService
{
    let tagsURL = kBaseURL + "tags/"
    var notificationToken: NotificationToken?
    
    func getTags(page:Int , completion :@escaping (_ tags:[Tag]) -> ())
    {
        if Reachability.isConnectedToNetwork()
        {
            getTagsFromAPIWith(page: page , completion:  { (tags) in
                completion(tags)
            })
        }else
        {
            getTagsFromLocal(completion:  { (tags) in
                completion(tags)
            })
        }

    }
    
    func loadMoreTags(page:Int , completion :@escaping (_ tags:[Tag]) -> () )
    {
        if Reachability.isConnectedToNetwork()
        {
            getTagsFromAPIWith(page: page , completion:  { (tags) in
                completion(tags)
            })
        }
    }
    private func getTagsFromAPIWith(page:Int ,  completion :@escaping (_ tags:[Tag]) -> ())
    {
        Alamofire.request(tagsURL + "\(page)", method: .get, parameters: nil , encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completion([])
                    return
                }
                let tags = try? JSONDecoder().decode(TagsResponse.self, from: data)
                completion(tags?.tags ?? [] )
                self.setDataForTags(tags:tags?.tags ?? [])
            case .failure(_):
                completion([])
            }
        })
    }
    
    
    
    
    
    func setDataForTags(tags:[Tag])
    {
        let realm = try! Realm()
        
        for tag in tags
        {
            try! realm.write {
                realm.add(tag)
            }
        }
    }
    func getTagsFromLocal( completion :@escaping (_ tags:[Tag]) -> ()) {
        let realm = try! Realm()
        let tags = realm.objects(Tag.self)
        var array = [Tag]()
        for tag in tags
        {
            array.append(tag)
        }
        completion(array)

    }
}
