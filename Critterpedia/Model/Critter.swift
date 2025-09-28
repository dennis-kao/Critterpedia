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
    var location: String?
    var price: Int
    var timesText: String
    var times: [Int]
    var northernMonths: [Int]
    var southernMonths: [Int]
    var imageName: String
    var iconName: String {
        get {
            return "icon-\(self.imageName)"
        }
    }

    enum Category: String {
      case Fish
      case Insect
      case Sea
    }

    enum FilterOptions {
        case Name
        case Month
        case MonthHour
    }

    init(name: String, location: String?, price: Int, timesText: String, times: [Int], northernMonths: [Int], southernMonths: [Int]) {

        self.name = name.replacingOccurrences(of: "_", with: " ").capitalized
        self.location = (location == nil) ? "Sea (diving)" : location
        self.price = price
        self.timesText = timesText
        self.times = times
        self.northernMonths = northernMonths
        self.southernMonths = southernMonths

        self.imageName = name.replacingOccurrences(of: "_", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "'", with: "").replacingOccurrences(of: " ", with: "").lowercased()

        print(imageName)
    }
}

final class CritterParser {
    static func parse(key: String, dict: [String: Any]) -> Critter? {
        guard let nameDict = dict["name"] as? [String: String], let name = nameDict["name-USen"] else { return nil }
        guard let availability = dict["availability"] as? [String: Any] else { return nil }
        guard let price = dict["price"] as? Int else { return nil }
        guard let isAllDay = availability["isAllDay"] as? Bool, let timesText = (isAllDay) ? "All day" : availability["time"] as? String, let times = availability["time-array"] as? [Int] else { return nil }
        guard let northernMonths = availability["month-array-northern"] as? [Int]  else { return nil }
        guard let southernMonths = availability["month-array-southern"] as? [Int] else { return nil }

        let location = availability["location"] as? String

        return Critter(name: name, location: location, price: price, timesText: timesText, times: times, northernMonths: northernMonths, southernMonths: southernMonths)
    }

    static func loadJson(filename fileName: String) -> [Critter]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)

                guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: [String: Any]] else {
                    print("Could not serialize")
                    return nil
                }

                return jsonArray.compactMap({CritterParser.parse(key: $0, dict: $1)}).sorted(by: {$0.name < $1.name})
            } catch {
                print("Error while parsing Critter data: \(error)")
            }
        }
        return nil
    }
}
