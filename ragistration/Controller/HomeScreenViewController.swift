//
//  RagistrationViewController.swift
//  ragistration
//
//  Created by R&W on 16/12/22.
//

import UIKit

class HomeScreenViewController: UIViewController {

 
    @IBOutlet weak var tableView: UITableView!
    var arrUserDetails: [Users] = []
    
    var name: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
    }
    private func registerNib(){
        tableView.register(UINib(nibName: "LoginTableViewCell", bundle: nil), forCellReuseIdentifier: "LoginTableViewCell")
        tableView.separatorStyle = .none
    }
  }
extension HomeScreenViewController: UITableViewDelegate,UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUserDetails.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LoginTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LoginTableViewCell", for: indexPath)   as! LoginTableViewCell
        let userData = arrUserDetails[indexPath.row]
        cell.labelOne.text = "\(userData.email)"
        cell.labelTwo.text = "\(userData.gender)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
