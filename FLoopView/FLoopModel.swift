//
//  FLoopModel.swift
//  FLoopViewDemo
//
//  Created by Fang on 2020/9/10.
//

import Foundation


struct FLoopModel : FLoopModelProtocol {
    var name: String?
    
    var imageUrl: String?
    
    var string: String?
    
    init(string: String) {
        self.string = string
        self.name = nil
        self.imageUrl = nil
    }
}
