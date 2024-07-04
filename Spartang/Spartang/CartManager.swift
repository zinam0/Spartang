//
//  CartManager.swift
//  Spartang
//
//  Created by t2023-m0019 on 7/4/24.
//

import Foundation

class CartManager {
    
    var menu:[Menu] = []
    var totalPrice = 0

}

struct Menu {
    let name: String
    var quantity: Int
    let price: Int
}
