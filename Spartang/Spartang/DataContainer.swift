//
//  DataContainer.swift
//  Spartang
//
//  Created by 남지연 on 7/4/24.
//

import Foundation

class DataContainer {
    static let shared = DataContainer()
    
    private init() {
        
    }
    var menuItems: [String: [Menu?]] = [
        "베스트": [
            
        ],
        "탕": [
            Menu(name: "탕", image: "image2", price: 8000)
        ],
        "사이드": [
            Menu(name: "오뎅탕", image: "image3", price: 10000)
        ],
        "소주/맥주": [
            Menu(name: "진로", image: "image4", price: 100000),
            Menu(name: "하이트", image: "image4", price: 100000),
            Menu(name: "카스", image: "image4", price: 100000),
            Menu(name: "참이슬", image: "image4", price: 100000),
        ],
        "음료": [
            Menu(name: "음료", image: "image1", price: 1000)
        ]
    ]
}
