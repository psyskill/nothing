//
//  ObjectDemo.swift
//  Netscore
//
//  Created by Yousuf Yesil on 16.12.22.
//

import Foundation
class ObjectDemo: Encodable{
    var id:String = ""
    var value: String = ""
}

extension Encodable{
    var toDictionary: [String: Any]?{
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        
    }
}
