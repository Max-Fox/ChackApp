//
//  Model.swift
//  ChackApp
//
//  Created by Максим Лисица on 16/03/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//
//http://api.icndb.com/jokes/random

import UIKit

class Model: NSObject {
    
    func loadJoke() -> String {
        var returnJoke: String = ""
        
        let url = NSURL(string: "http://api.icndb.com/jokes/random")!
        let data = NSData(contentsOf: url as URL)
        do{
            let dict = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            
            
            if (dict.object(forKey: "type") as! String == "success"){
               returnJoke = (dict.object(forKey: "value") as! NSDictionary).object(forKey: "joke") as! String
            }
            else {
                returnJoke = "Ошибка при распаковке JSON"
            }
            
            
        } catch {
            returnJoke = "Ошибка при распаковке JSON: \(error)"
        }
        
        return returnJoke.replacingOccurrences(of: "&quot;", with: "\"")
    }

}
