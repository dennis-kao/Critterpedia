//
//  Critter.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-04-29.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import UIKit

struct Critter {
    var name: String
    var location: String
    var price: Int
    var timesText: String
    var times: [Int]
    var northernMonths: [Int]
    var southernMonths: [Int]
    var iconName: String
    var imageName: String
    
    enum Category: String {
      case Fish
      case Insect
    }
    
    enum FilterOptions {
        case Name
        case Month
        case MonthHour
    }
    
    init(name: String, location: String, price: Int, timesText: String, times: [Int], northernMonths: [Int], southernMonths: [Int]) {
        
        self.name = name
        self.location = location
        self.price = price
        self.timesText = timesText
        self.times = times
        self.northernMonths = northernMonths
        self.southernMonths = southernMonths
        
        self.imageName = name.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "'", with: "").lowercased()
        self.iconName = "icon-\(self.imageName)"
    }
}

final class CritterParser {
    static func parse(_ dictionary: [String: Any]) -> Critter? {
        guard let name = dictionary["name"] as? String else { return nil }
        guard let location = dictionary["location"] as? String else { return nil }
        guard let price = dictionary["price"] as? Int else { return nil }
        guard let timesDict = dictionary["times"] as? Dictionary<String, Any>, let timesText = timesDict["text"] as? String, let times = timesDict["array"] as? [Int] else { return nil }
        guard let monthsDict = dictionary["months"] as? Dictionary<String, Any>  else { return nil }
        guard let northernDict = monthsDict["northern"] as? Dictionary<String, Any>, let northernMonths = northernDict["array"] as? [Int]  else { return nil }
        guard let southernDict = monthsDict["southern"] as? Dictionary<String, Any>, let southernMonths = southernDict["array"] as? [Int] else { return nil }
        
        return Critter(name: name, location: location, price: price, timesText: timesText, times: times, northernMonths: northernMonths, southernMonths: southernMonths)
    }
    
    static func loadJson(filename fileName: String) -> [Critter]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                
                guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [Dictionary<String, Any>] else {
                    return nil
                }
                
                return jsonArray.compactMap({CritterParser.parse($0)}).sorted(by: {$0.name < $1.name})
            } catch {
                print("Error while parsing Critter data: \(error)")
            }
        }
        return nil
    }
}
