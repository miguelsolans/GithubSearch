//
//  UserSearchCell.swift
//  GitHubSearch
//
//  Created by Miguel Solans on 28/01/2022.
//

import Foundation
import UIKit

class UserSearchCell : UITableViewCell {
    
    let userImageView: UIImageView = {
        let imageView = UIImageView();
        
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.layer.masksToBounds = true;
        imageView.layer.cornerRadius = 50;
        imageView.contentMode = .scaleAspectFill;
        imageView.image = UIImage(imageLiteralResourceName: "userdefault")
        
        return imageView;
    }();
    
    let usernameLabel: UILabel = {
        let usernameLabel = UILabel();
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false;
        usernameLabel.numberOfLines = 0;
        usernameLabel.lineBreakMode = .byWordWrapping;
        usernameLabel.textColor = whiteLabel
        
        return usernameLabel;
    }();
    
    let userInfoStack : UIStackView = {
        let userInfoStack = UIStackView();
        
        userInfoStack.axis = .horizontal;
        
        
        return userInfoStack;
    }();
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.backgroundColor = darkBlueBackground;
        
        self.addSubview(userImageView);
        self.addSubview(usernameLabel);
        
        
        
        // User ImageView Constraints
        NSLayoutConstraint.activate([
            self.userImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            self.userImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            self.userImageView.widthAnchor.constraint(equalToConstant: 100),
            self.userImageView.heightAnchor.constraint(equalToConstant: 100),
        ]);
        
        // Username Label Constraints
        NSLayoutConstraint.activate([
            self.usernameLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 20),
            self.usernameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 20),
            
            self.usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]);
        
        
    }

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
