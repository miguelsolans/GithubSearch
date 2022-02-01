//
//  HeaderUserView.swift
//  GitHubSearch
//
//  Created by Miguel Solans on 29/01/2022.
//

import Foundation
import UIKit

protocol HeaderUserViewDelegate {
    func didPressWebsiteButton();
}

class HeaderUserView : UIView {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var websiteButton: UIButton!
    var delegate: HeaderUserViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupInterface();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupInterface()
    }
    
    
    func setupInterface() -> Void {
        guard let nibView = self.loadViewFromNib() else { return }
        
        nibView.frame = self.bounds;
        
        self.addSubview(nibView);
        
        self.backgroundColor = darkBlueBackground;
        
        self.userImageView.layer.masksToBounds = true;
        self.userImageView.layer.cornerRadius = self.userImageView.frame.width / 2;
        self.userImageView.image = UIImage(imageLiteralResourceName: "userdefault");
        
        self.usernameLabel.textColor = .white;
        self.usernameLabel.font = self.usernameLabel.font.withSize(25);
        
        self.fullnameLabel.textColor = .white;
        self.fullnameLabel.font = self.fullnameLabel.font.withSize(20);
        
        self.companyLabel.textColor = .white;
        self.companyLabel.font = self.companyLabel.font.withSize(20);
        
        self.websiteButton.setTitleColor(.white, for: .normal)
        self.websiteButton.titleLabel?.font = self.websiteButton.titleLabel?.font.withSize(18);
        self.websiteButton.titleLabel?.lineBreakMode = .byCharWrapping;
        self.websiteButton.titleLabel?.numberOfLines = 0;
        
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "HeaderUserView", bundle: nil);
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView;
    }
    @IBAction func websiteButtonPressed(_ sender: Any) {
        self.delegate?.didPressWebsiteButton();
    }
    
}
