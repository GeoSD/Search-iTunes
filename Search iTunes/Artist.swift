//
//  Artist.swift
//  Search iTunes
//
//  Created by Georgy Dyagilev on 07/11/2018.
//  Copyright © 2018 Georgy Dyagilev. All rights reserved.
//

import Foundation

struct Artist: Codable {
    var artistName: String
    var trackName: String
    var artworkUrl60: String
    var previewUrl: String
}

struct Results: Codable {
    var results: [Artist]
}

func loadData(from url: URL, complition: @escaping ([Artist]) -> Void) {
    var results = [Artist]()
    
//    if let data = try? Data(contentsOf: url) {
//
//        let decoder = JSONDecoder()
//        if let jsonData = try? decoder.decode(Results.self, from: data) {
//            results = jsonData.results
//        }
//        complition(results)
//    }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
            let decoder = JSONDecoder()
            
            if let jsonData = try? decoder.decode(Results.self, from: data) {
                results = jsonData.results
                DispatchQueue.main.async {
                    complition(results)
                }
            }
            
        }
    }
    task.resume()
}
    


