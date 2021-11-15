//
//  ReviewTableViewController.swift
//  Snacktacular1
//
//  Created by Christopher Rea on 11/8/21.
//

import UIKit
import Firebase

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    return dateFormatter
}()

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
    
    @IBOutlet var starButtonCollection: [UIButton]!
    
    
    var review: Review!
    var spot: Spot!
    var rating = 0 {
        didSet {
            for starButton in starButtonCollection {
                let imageName = (starButton.tag < rating ? "star.fill" : "star")
                starButton.setImage(UIImage(systemName: imageName), for: .normal)
                starButton.tintColor = (starButton.tag < rating ? .systemRed : .darkText)
            }
            print("<< new rating")
            review.rating = rating
        }
    }
    
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
            rating = review.rating
            reviewDateLabel.text = "posted: \(dateFormatter.string(from: review.date))"
            if review.documentID == "" {
                addBordersToEditableObjects()
            } else {
                if review.reviewUserID == Auth.auth().currentUser?.uid {
                    self.navigationItem.leftItemsSupplementBackButton = false
                    saveBarButton.title = "Update"
                    addBordersToEditableObjects()
                    deleteButton.isHidden = false
                } else {
                    saveBarButton.hide()
                    cancelBarButton.hide()
                    postedByLabel.text = "Posted by: \(review.reviewUserEmail)"
                    for starButton in starButtonCollection {
                        starButton.backgroundColor = .white
                        starButton.isEnabled = false
                    }
                    reveiwTitleField.isEnabled = false
                    reveiwTitleField.borderStyle = .none
                    reviewTextView.isEditable = false
                    reveiwTitleField.backgroundColor = .white
                    reviewTextView.backgroundColor = .white
                }
            }
        }
        
        func updateFromUserInterface() {
            review.title = reveiwTitleField.text!
            review.text = reviewTextView.text!
        }
    func addBordersToEditableObjects() {
        reveiwTitleField.addBorder(width: 0.5, radius: 5.0, color: .black)
        reviewTextView.addBorder(width: 0.5, radius: 5.0, color: .black)
        buttonBackgroundView.addBorder(width: 0.5, radius: 5.0, color: .black)

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
    
    @IBAction func starButtonPressed(_ sender: UIButton) {
        rating = sender.tag + 1
    }
    
}
