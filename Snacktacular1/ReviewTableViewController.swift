//
//  ReviewTableViewController.swift
//  Snacktacular1
//
//  Created by Christopher Rea on 11/8/21.
//

import UIKit

class ReviewTableViewController: UITableViewController {
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var postedByLabel: UILabel!
    @IBOutlet weak var buttonBackgroundView: UIView!
    @IBOutlet weak var reveiwTitleField: UITextField!
    @IBOutlet weak var reviewDateLabel: UILabel!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var review: Review!
    var spot: Spot!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard spot != nil else {
            print("Error: No spot passed")
            return
        }
        if review == nil {
            review = Review()
            }
        updateUserInterface()
        }
    
        func updateUserInterface() {
            nameLabel.text = spot.name
            addressLabel.text = spot.address
            reveiwTitleField.text = review.title
            reviewTextView.text = review.text
        }
        
        func updateFromUserInterface() {
            review.title = reviewTitleField.text!
            review.text = reviewTextView.text!
        }
    
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func reviewTitleChange(_ sender: UITextField) {
    }
    @IBAction func reviewTitleDonePressed(_ sender: UITextField) {
    }
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
    }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        updateFromUserInterface()
        review.saveData(spot: spot) { (success) in
            if success {
                self.leaveViewController()
            } else {
                print("Error")
            }
        }
    }
}
