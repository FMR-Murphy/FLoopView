//
//  FLoopViewCell.swift
//  FLoopViewDemo
//
//  Created by Fang on 2020/9/9.
//

import UIKit

class FLoopViewCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
    
    func createUI() {
        
        contentView.addSubview(imageView)
        let left = NSLayoutConstraint.init(item: imageView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0)
        left.isActive = true
        let right = NSLayoutConstraint.init(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0)
        right.isActive = true
        let top = NSLayoutConstraint.init(item: imageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 2.5)
        top.isActive = true
        let bottom = NSLayoutConstraint.init(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -2.5)
        bottom.isActive = true
        contentView.addConstraints([left,right,top,bottom])
        
        contentView.addSubview(label)
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        
    }
}
