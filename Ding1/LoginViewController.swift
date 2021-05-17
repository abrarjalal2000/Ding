//
//  LoginViewController.swift
//  Ding1
//
//  Created by adnan jalal on 5/15/21.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkUserInfo()
        //self.performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
    func checkUserInfo() {
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.uid as Any)
            guard let currentUser = Auth.auth().currentUser else {
                print("😡 ERROR: Couldn't get currentUser")
                return
            }
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
//            let dingUser = DingUser(user: currentUser)
//            dingUser.saveIfNewUser { (success) in
//                if success {
//                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
//                } else {
//                    print("😡 ERROR: Tried to save a new DingUser, but failed")
//                }
//            }
            
            
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] authResult,err in
            guard let strongSelf = self else {return}
            if let err = err {
                self!.oneButtonAlert(title: "Login Failed:", message: "Invalid email address or password entered")
                print(err.localizedDescription)
            }
            self!.checkUserInfo()
        }
    }
    
    func validateFields() {
        var check = true
        if emailTextField.text?.isEmpty == true {
            print("No text in email field")
            check = false
        }
        else if passwordTextField.text?.isEmpty == true {
            print("No text in password field")
            check = false
        }
        if check == false {
            self.oneButtonAlert(title: "Login Failed:", message: "Please do not leave any fields blank.")
        }
        login()
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        validateFields()
    }
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "signUp", sender: sender)
    }
    @IBAction func unwindSignOutPressed(segue: UIStoryboardSegue){
        if segue.identifier == "SignOutUnwind" {
            do {
                try Auth.auth().signOut()
                print("^^^ Successfully signed out!")
                
            } catch {
                print("*** ERROR: Couldn't sign out")
                performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        
    }
}
