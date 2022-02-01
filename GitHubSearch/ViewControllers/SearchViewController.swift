//
//  ViewController.swift
//  GitHubSearch
//
//  Created by Miguel Solans on 25/01/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    var githubModel = GithubUserModel()
    let tableView = UITableView()
    let searchBarController = UISearchController()
    
    var searchOutput : SearchUsersOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.githubModel.delegate = self;
        
        self.view.addSubview(self.tableView);
        self.navigationController?.title = "Search GitHub"
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false;
        self.tableView.register(UserSearchCell.self, forCellReuseIdentifier: "UserSearchCell");
        
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ]);
        
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        
        // Search Bar
        self.searchBarController.searchBar.placeholder = "Type a Name";
        self.searchBarController.searchBar.barStyle = .default;
        self.searchBarController.searchBar.showsSearchResultsButton = false;
        self.searchBarController.searchBar.delegate = self;
        self.searchBarController.searchBar.sizeToFit();
        self.searchBarController.searchBar.tintColor = whiteLabel;
        
        self.navigationItem.searchController = self.searchBarController;
        self.navigationItem.hidesSearchBarWhenScrolling = true;
        self.title = "Github Search"
        
        
        self.tableView.backgroundColor = darkBlueBackground;
        
        
    }
    
    
}
    

// MARK: - Search Bar Delegate Methods
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchQuery = self.searchBarController.searchBar.text;
        
        if(searchQuery != "") {
            self.githubModel.fetchAccountsWith(keyword: searchQuery!);
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchOutput = nil;
        
        self.tableView.reloadData()
    }
}
    
// MARK: - TableView Delegate Methods
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UserSearchCell? = self.tableView.dequeueReusableCell(withIdentifier: "UserSearchCell", for: indexPath) as? UserSearchCell
        
        if(cell == nil) {
            cell = UserSearchCell(style: .default, reuseIdentifier: "UserSearchCell");
        }
        
        
        if let avatarUrl = self.searchOutput?.items[ indexPath.row ].avatarUrl {
            let imageUrl = URL(string:avatarUrl);
            let data = try? Data(contentsOf: imageUrl!);
            cell?.userImageView.image = UIImage(data: data!);
        }
        
        cell?.usernameLabel.text = self.searchOutput?.items[ indexPath.row ].username;
        
        
        return cell!;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.searchOutput?.items.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let username = self.searchOutput?.items[ indexPath.row ].username;
        
        self.githubModel.fetchAccountInformation(username: username!);
        self.tableView.deselectRow(at: indexPath, animated: true);
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150;
    }
}

// MARK: - Networking Delegate Methods
extension SearchViewController: GithubUserModelDelegate {
    func searchOutputDidChange(output: SearchUsersOutput) {
        
        self.searchOutput = output;
        
        DispatchQueue.main.async {
            
            if(self.searchOutput?.totalCount == 0) {
                
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
    
    func userInfoOutputDidChange(output: UserInfoOutput) {
        
        DispatchQueue.main.async {
            let userViewController = UserInformationViewController()
            
            userViewController.userInfoOutput = output;
            
            self.navigationController?.pushViewController(userViewController, animated: true)
        }
    }
}
