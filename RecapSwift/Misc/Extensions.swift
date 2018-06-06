//
//  Serializable.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-19.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

extension Decodable {
    static func decode(data: Data) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: data)
    }
}

extension UISegmentedControl {
    func items(_ items: [String]) {
        for (index, item) in items.enumerated() {
            self.insertSegment(withTitle: item, at: index, animated: false)
        }
    }
}

extension Encodable {
    func encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }
}

extension Data {
    func toString() -> String {
        guard let string = String(data: self, encoding: .utf8) else { return "" }
        return string
    }
    
    func extractJSON(key: String, paths: [String]) -> Data? {
        
        var dict = [String: Any]()
        
        do {
            let jsonString = try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
            
            guard let json = jsonString else { return nil }
            
            for path in paths {
                guard let jsonPath = json[path] as? [String:Any] else { return nil }
                dict = jsonPath
            }
            
            guard let data = try? JSONSerialization.data(withJSONObject: dict[key], options: []) else { return nil }
            
            return data
            
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}

extension String {
    func URLEncoded() -> String {
        return self.replacingOccurrences(of: " ", with: "%20")
    }
}

extension UICollectionView {
    func dislpayEmptyWith(_ message: String) {
        let temp = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        temp.text = message
        temp.textColor = UIColor.black
        temp.numberOfLines = 0
        temp.textAlignment = .center
        temp.font = UIFont(name: "Helvetica", size: 17.0)
        temp.sizeToFit()
        self.backgroundView = temp
    }
    
    func reset() {
        self.backgroundView = nil
    }
}
