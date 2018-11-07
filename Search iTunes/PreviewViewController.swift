//
//  PreviewViewController.swift
//  Search iTunes
//
//  Created by Georgy Dyagilev on 07/11/2018.
//  Copyright © 2018 Georgy Dyagilev. All rights reserved.
//

import UIKit
import WebKit

class PreviewViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var stringURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: stringURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

}
