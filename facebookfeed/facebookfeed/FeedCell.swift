//
//  FeedCell.swift
//  facebookfeed
//
//  Created by andyron<http://andyron.com> on 2018/5/31.
//  Copyright © 2018年 andyron. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class FeedCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            
            
           
            statusImageView.image = nil
            if let statusImageUrl = post?.statusImageUrl {
                if let image = imageCache[statusImageUrl] {
                    statusImageView.image = image
                } else {
                    let request = URLRequest(url: URL(string: statusImageUrl)!)
//                    URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
//
//                        if error != nil {
//                            print(error)
//                            return
//                        }
//                        let image = UIImage(data: data!)
//                        imageCache[statusImageUrl] = image
//
//                        let queue = DispatchQueue(label: "queue")
//                        queue.async {
//                            self.statusImageView.image = image
//                            self.loader?.stopAnimating()
//                        }
//
//                    }
                    
                    URLSession.shared.dataTask(with: request, completionHandler: {
                        (data, response, error) -> Void in
                        if error != nil {
                            print(error)
                            return
                        }
                        let image = UIImage(data: data!)
                        imageCache[statusImageUrl] = image
                        
                        DispatchQueue.global(qos: .userInitiated).async {
                            DispatchQueue.main.async {
                                self.statusImageView.image = image
                                self.loader.stopAnimating()
                            }
                        }
                    }).resume()
                }
            }
            self.setupNameLocationStatusAndProfileImage()
        }
    }

    func setupNameLocationStatusAndProfileImage() {
        if let name = post?.name {
            let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
            
            attributedText.append(NSAttributedString(string: "\nDecember 18 • San Francisco • ", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 12), NSAttributedStringKey.foregroundColor:
                UIColor.rgb(r: 155, g: 161, b: 171)]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
            
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: "globe_small")
            attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
            attributedText.append(NSAttributedString(attachment: attachment))
            
            nameLabel.attributedText = attributedText
        }
        if let statusText = post?.statusText {
            statusTextView.text = statusText
        }
        
        if let profileImageName = post?.profileImageName {
            profileImageView.image = UIImage(named: profileImageName)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "zuckprofile")
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
//        textView.text = "Meanwhile, Beast turned to the dark side."
        textView.font = UIFont.boldSystemFont(ofSize: 14)
        textView.isScrollEnabled = false
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "zuckdog")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
        label.text = "433Likes 11.1K Comments"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.rgb(r: 155, g: 161, b: 171)
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(r: 226, g: 228, b: 232)
        return view
    }()
    
    let likeButton = FeedCell.buttonForTitle(title: "Like", imageName: "like")
    let commentButton = FeedCell.buttonForTitle(title: "Comment", imageName: "comment")
    let shareButton = FeedCell.buttonForTitle(title: "Share", imageName: "share")
    
    static func buttonForTitle(title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.rgb(r: 143, g: 150, b: 163), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }
    
    func setupViews() {
        backgroundColor = UIColor.white
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        addSubview(dividerLineView)
        
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        
        
        //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0(44)]-8-[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImageView, "v1": nameLabel]))
        //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0(44)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImageView]))
        
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        
        addConstraintsWithFormat(format: "H:|-12-[v0]|", views: likesCommentsLabel)
        
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: dividerLineView)
        
        
        // button constraint
        addConstraintsWithFormat(format: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)
        
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: nameLabel)
        
        //        8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.4)][v5(44)]|", views: profileImageView,statusTextView,statusImageView,likesCommentsLabel,dividerLineView,likeButton)
        
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: commentButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: shareButton)
        
    }
    let loader = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    func setupStatusImageViewLoader() {
        loader.hidesWhenStopped = true
        loader.startAnimating()
        loader.color = UIColor.black
        statusImageView.addSubview(loader)
        statusImageView.addConstraintsWithFormat(format:"H:|[v0]|", views: loader)
        statusImageView.addConstraintsWithFormat(format:"V:|[v0]|", views: loader)
    }
}
