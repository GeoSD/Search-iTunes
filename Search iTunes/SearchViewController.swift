//
//  SearchViewController.swift
//  Search iTunes
//
//  Created by Georgy Dyagilev on 07/11/2018.
//  Copyright © 2018 Georgy Dyagilev. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        updateSearchButtonState()
        setupViewResizerOnKeyboardShown()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let searchText = searchTextField.text else { return }
        guard segue.identifier == "ToResults" else { return }
        
        guard let navigationController = segue.destination as? UINavigationController else { return }
        guard let resultsTableViewController = navigationController.topViewController as? ResultsTableViewController else { return }
        
        resultsTableViewController.searchText = searchText
    }

    @IBAction func searchButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSearchButtonState()
    }
    
    func updateSearchButtonState() {
        let searchText = searchTextField.text ?? ""
        searchButton.isEnabled = !searchText.isEmpty
    }
}

// From Angular Acceleration app by D.Bystruev
extension UIViewController {
    
    @objc func keyboardWillResize(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let window = view.window?.frame {
            
            let height: CGFloat
            
            if notification.name == UIResponder.keyboardWillShowNotification {
                // We're not just minusing the kb height from the view height because
                // the view could already have been resized for the keyboard before
                height = window.origin.y + window.height - keyboardSize.height
            } else {
                let viewHeight = view.frame.height
                height = viewHeight + keyboardSize.height
            }
            
            view.frame = CGRect(
                x: view.frame.origin.x,
                y: view.frame.origin.y,
                width: view.frame.width,
                height: height
            )
        }
    }
    
    func setupViewResizerOnKeyboardShown() {
        
        let names: [NSNotification.Name] = [
            UIResponder.keyboardWillShowNotification,
            UIResponder.keyboardWillHideNotification
        ]
        
        for name in names {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(keyboardWillResize),
                name: name,
                object: nil
            )
        }
    }
    
}
