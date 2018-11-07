//
//  ResultsTableViewController.swift
//  Search iTunes
//
//  Created by Georgy Dyagilev on 07/11/2018.
//  Copyright © 2018 Georgy Dyagilev. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var results = [Artist]()
    var images = [UIImage]()
    
    var searchText: String = ""
    var query: [String: String] = [:]
    
    let basicURL = URL(string: "https://itunes.apple.com/search")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        query = ["term": searchText, "country": "ru", "entity": "musicVideo"]
        if let url = basicURL?.withQueries(query) {
            results = loadData(from: url)
        }
        
        for index in results.indices {
            let image = loadImage(from: results[index].artworkUrl60)
            images.append(image!)
        }
        
        navigationItem.title = "Search results for : \(searchText)."
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath)
        
        let result = results[indexPath.row]
        let image = images[indexPath.row]
        
        cell.textLabel?.text = result.trackName
        cell.detailTextLabel?.text = result.artistName
        cell.imageView?.image = image
        
        return cell
    }
    
    // MARK: - Navigation
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PreviewSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let previewViewController = segue.destination as! PreviewViewController
                previewViewController.stringURL = results[indexPath.row].previewUrl
            }
        }
    }
    
    func loadImage(from stringURL: String) -> UIImage? {
        guard let url = URL(string: stringURL) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        let image = UIImage(data: data)
        return image
    }
}

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        return components?.url
    }
}
