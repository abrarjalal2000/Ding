//
//  SocialMediaDetailViewController.swift
//  Ding1
//
//  Created by adnan jalal on 5/16/21.
//

import UIKit

class SocialMediaDetailViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var platformTextField: UITextField!
    @IBOutlet weak var handleTextField: UITextField!

    var socialmedia: SocialMedia!

    override func viewDidLoad() {
        super.viewDidLoad()
        if socialmedia == nil {
            socialmedia = SocialMedia()
        }
        updateUserInterface()
    }

    func updateUserInterface() {
        nameTextField.text = socialmedia.name
        userNameTextField.text = socialmedia.user_name
        platformTextField.text = socialmedia.platform
        handleTextField.text = socialmedia.handle
    }

    func updateFromInterface() {
        socialmedia.name =  nameTextField.text!
        socialmedia.user_name = userNameTextField.text!
        socialmedia.platform = platformTextField.text!
        socialmedia.handle = handleTextField.text!
    }

    func leaveViewController () {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        updateFromInterface()
        socialmedia.saveData { success in
            if success {
                self.leaveViewController()
            } else {
                self.oneButtonAlert(title: "Save Failed", message: "For some reason, the data would not save to the cloud.")
            }
        }
    }
}
