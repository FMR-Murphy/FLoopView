//
//  ViewController.swift
//  FLoopViewDemo
//
//  Created by Fang on 2020/9/9.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var loopView :FLoopView = {
        let loopView = FLoopView()
        loopView.translatesAutoresizingMaskIntoConstraints = false
        loopView.backgroundColor = .green
        return loopView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createUI()
        
        let array = [FLoopModel(string: "1"), FLoopModel(string: "2")]
        loopView.updateArray(array: array)
        loopView.numberOfPage = 1
    }
    
    func createUI() {
        view.addSubview(loopView)
        let left = NSLayoutConstraint.init(item: loopView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint.init(item: loopView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 100)
        let right = NSLayoutConstraint.init(item: loopView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint.init(item: loopView, attribute: .height, relatedBy: .equal, toItem: loopView, attribute: .width, multiplier: 500/375.0, constant: 0)
        
        NSLayoutConstraint.activate([left,top,right, height])
        view.addConstraints([left,top,right])
        loopView.addConstraint(height)
        
    }


}

