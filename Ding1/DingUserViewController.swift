//
//  DingUserViewController.swift
//  Ding1
//
//  Created by adnan jalal on 5/16/21.
//

import UIKit

class DingUserViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortSegmentControl: UISegmentedControl!
    
    var users = ["AJ","Matty","Gabe"]
    
    var dingUsers: DingUsers!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        dingUsers = DingUsers()
        dingUsers.loadData {
            self.tableView.reloadData()
        }
        configureSegmentedControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sortSegmentControl.selectedSegmentIndex = 0
    }
    
    func configureSegmentedControl() {
        let purpleFontColor = [NSAttributedString.Key.foregroundColor : UIColor(named: "PrimaryColor") ?? UIColor.purple]
        let whiteFontColor = [NSAttributedString.Key.foregroundColor : UIColor.white]
        sortSegmentControl.setTitleTextAttributes(purpleFontColor, for: .selected)
        sortSegmentControl.setTitleTextAttributes(whiteFontColor, for: .normal)
        sortSegmentControl.layer.borderColor = UIColor.white.cgColor
        sortSegmentControl.layer.borderWidth = 1.0
    }
    
    @IBAction func segmentControlChnaged(_ sender: UISegmentedControl) {
        if (sortSegmentControl.selectedSegmentIndex == 1) {
            navigationController?.popViewController(animated: false)
        } else if (sortSegmentControl.selectedSegmentIndex == 0) {
            navigationController?.popViewController(animated: false)
        }
    }
}

extension DingUserViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dingUsers.dingUsersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleCell", for: indexPath) as! DingUserTableViewCell
        cell.dingUser = dingUsers.dingUsersArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
