//
//  SignUpViewController.swift
//  Ding1
//
//  Created by adnan jalal on 5/15/21.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    func signUp() {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, err) in
            guard let user = authResult?.user, err == nil else {
                print("ERROR: \(err?.localizedDescription)")
                return
            }
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = self.storyboard?.instantiateViewController(identifier: "homePage")
//            vc?.modalPresentationStyle = .overFullScreen
//            self.present(vc!,animated: true)
        }
    }
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        var check = true
        if nameTextField.text?.isEmpty == true {
            print("No text in name field")
            check = false
        }
        if emailTextField.text?.isEmpty == true {
            print("No text in email field")
            check = false
        }
        if usernameTextField.text?.isEmpty == true {
            print("No text in username field")
            check = false
        }
        if passwordTextField.text?.isEmpty == true {
            print("No text in password field")
            check = false
        }
        if check == false {
            self.oneButtonAlert(title: "Signup Failed", message: "Please do not leave any fields blank.")
        }
        signUp()
        guard let currentUser = Auth.auth().currentUser else {
            print("😡 ERROR: Couldn't get currentUser")
            return
        }
        let dingUser = DingUser(user: currentUser)
        dingUser.saveIfNewUser { (success) in
            if success {
                self.navigationController!.popViewController(animated: true)
            } else {
                print("😡 ERROR: Tried to save a new SnackUser, but failed")
            }
        }
        //self.performSegue(withIdentifier: "ShowUsers", sender: nil)

        
    }
    @IBAction func alreadyHaveAnAccountButtonPressed(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard?.instantiateViewController(identifier: "logIn")
//        vc?.modalPresentationStyle = .overFullScreen
//        present(vc!,animated: true)
    }
    
}
