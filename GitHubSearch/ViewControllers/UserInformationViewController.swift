//
//  UserInformationViewController.swift
//  GitHubSearch
//
//  Created by Miguel Solans on 28/01/2022.
//

import Foundation
import UIKit

class UserInformationViewController : UIViewController {
    
    
    var userInfoOutput: UserInfoOutput?
    var repositoriesModel = RepositoriesModel();
    var output: [RepositoryInfoOutput]?;
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        self.view.backgroundColor = darkBlueBackground;
        
        self.title = "Profile"
        self.setupInterface();
        
        self.repositoriesModel.delegate = self;
        self.repositoriesModel.fetchUserRepositories(username: self.userInfoOutput!.username);
        
    }
    
    func setupInterface() -> Void {
        
        
        let headerView = HeaderUserView();
        
        
        self.view.addSubview(headerView);
        
        
        headerView.usernameLabel.text = self.userInfoOutput!.username;
        headerView.fullnameLabel.text = self.userInfoOutput!.name;
        headerView.companyLabel.text = self.userInfoOutput!.company;
        headerView.delegate = self;
        
        if let avatarUrl = self.userInfoOutput?.avatarUrl {
            let imageUrl = URL(string:avatarUrl);
            let data = try? Data(contentsOf: imageUrl!);
            headerView.userImageView.image = UIImage(data: data!);
        }
        
        if(self.userInfoOutput!.webpage != "") {
            headerView.websiteButton.setTitle(self.userInfoOutput!.webpage, for: .normal);
        } else {
            headerView.websiteButton.isHidden = true;
        }
        
        headerView.translatesAutoresizingMaskIntoConstraints = false;
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            headerView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200)
        ]);
        
        
        
        
        //
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.view.addSubview(self.tableView);
        self.tableView.translatesAutoresizingMaskIntoConstraints = false;
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell");
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]);
    }
    
    
    
    
}

// MARK: - TableView Delegate Methods
extension UserInformationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = self.output?[ indexPath.row ].name;
        cell.backgroundColor = darkBlueBackground;

        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.output?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let safeUrlStr = self.output?[ indexPath.row].url {
            if let safeUrl = URL(string: safeUrlStr) {
                UIApplication.shared.open(safeUrl)
            }
        }
        self.tableView.deselectRow(at: indexPath, animated: true);
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
}


// MARK: - User Header Delegate Methods
extension UserInformationViewController: HeaderUserViewDelegate {
    func didPressWebsiteButton() {
        if let safeUrlStr = self.userInfoOutput?.webpage {
            if let safeUrl = URL(string: safeUrlStr) {
                UIApplication.shared.open(safeUrl)
            }
        }
    }
}

// MARK: - Networking Delegate Methods
extension UserInformationViewController: RepositoriesModelDelegate {
    
    func didReceiveRepositoryInfo(output: [RepositoryInfoOutput]) {
        self.output = output;
        DispatchQueue.main.async {
            
            if(self.output?.count == 0) {
                
            } else {
                self.tableView.reloadData()
            }
        }
    }
    
    func didFailWithError(_ error: Error, endpoint: String) {
        print("\(error.localizedDescription): \(endpoint)");
        let alert = UIAlertController(title: "Oops!", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil);
        alert.addAction(okAction);
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil);
        }
    }
    
}

