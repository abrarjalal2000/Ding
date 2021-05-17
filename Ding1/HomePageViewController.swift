//
//  ViewController.swift
//  Ding1
//
//  Created by adnan jalal on 5/15/21.
//

import UIKit
import FirebaseAuth
import Firebase

class HomePageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sortSegmentControl: UISegmentedControl!
    @IBOutlet weak var nameLabel: UILabel!

    var socialmedias: SocialMedias!

    override func viewDidLoad() {
        super.viewDidLoad()
        //sortSegmentControl.selectedSegmentIndex = 1
        socialmedias = SocialMedias()
        tableView.delegate = self
        tableView.dataSource = self
        configureSegmentedControl()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sortSegmentControl.selectedSegmentIndex = 1
        socialmedias.loadData {
            self.tableView.reloadData()
        }
    }


    func configureSegmentedControl() {
        let purpleFontColor = [NSAttributedString.Key.foregroundColor : UIColor(named: "PrimaryColor") ?? UIColor.purple]
        let whiteFontColor = [NSAttributedString.Key.foregroundColor : UIColor.white]
        sortSegmentControl.setTitleTextAttributes(purpleFontColor, for: .selected)
        sortSegmentControl.setTitleTextAttributes(whiteFontColor, for: .normal)
        sortSegmentControl.layer.borderColor = UIColor.white.cgColor
        sortSegmentControl.layer.borderWidth = 1.0
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! SocialMediaDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.socialmedia = socialmedias.socialMediaArray[selectedIndexPath.row]
        }
    }
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        if (sortSegmentControl.selectedSegmentIndex == 0) {
            self.performSegue(withIdentifier: "ShowPeople", sender: nil)
        } else if (sortSegmentControl.selectedSegmentIndex == 1) {
            navigationController?.popViewController(animated: false)
        }
    }


}

extension HomePageViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return socialmedias.socialMediaArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = socialmedias.socialMediaArray[indexPath.row].platform
        cell.detailTextLabel?.text = socialmedias.socialMediaArray[indexPath.row].handle
        nameLabel.text = socialmedias.socialMediaArray[indexPath.row].name
        return cell
    }


}

