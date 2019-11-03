//
//  TagsService.swift
//  ElmenusTask
//
//  Created by Apple on 10/31/19.
//  Copyright © 2019 Muhammmed. All rights reserved.
//

import Foundation
import Alamofire

class TagsService
{
    let tagsURL = kBaseURL + "tags/"
    
    func getTags(page:Int , completion :@escaping (_ tags:[Tag]) -> ())
    {
        getTagsFromAPIWith(page: page , completion:  { (tags) in
            completion(tags)
        })
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
            case .failure(_):
                completion([])
            }
        })
    }
    
}
