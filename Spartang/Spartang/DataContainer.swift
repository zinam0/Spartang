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
    //dictionary
    var menuItems: [String: [Menu?]] = [
        "베스트": [
            Menu(
                image: "tang_5",
                name: "마라탕",
                price: 25000),
            Menu(
                image: "tang_7",
                name: "동태탕",
                price: 20000),
        ],
        "탕": [
            Menu(
                image: "tang_1",
                name: "꽃게탕",
                price: 25000),
            Menu(
                image: "tang_2",
                name: "어묵탕",
                price: 15000),
            Menu(
                image: "tang_3",
                name: "해물탕",
                price: 35000),
            Menu(
                image: "tang_4",
                name: "새우탕",
                price: 25000),
            Menu(
                image: "tang_5",
                name: "마라탕",
                price: 25000),
            Menu(
                image: "tang_6",
                name: "감자탕",
                price: 35000),
            Menu(
                image: "tang_7",
                name: "동태탕",
                price: 20000),
            Menu(
                image: "tang_8",
                name: "홍합탕",
                price: 10000),
            Menu(
                image: "tang_9",
                name: "알탕",
                price: 20000)
        ],
        "사이드": [
            Menu(
                image: "snack_1",
                name: "모듬회초밥",
                price: 25000),
            Menu(
                image: "snack_2",
                name: "초밥",
                price: 15000),
            Menu(
                image: "snack_3",
                name: "모둠회",
                price: 50000),
            Menu(
                image: "snack_4",
                name: "깻잎회롤",
                price: 25000)
        ],
        "소주/맥주": [
            Menu(
                image: "alcohol_1",
                name: "사케1",
                price: 25000),
            Menu(
                image: "alcohol_2",
                name: "사케2",
                price: 25000),
            Menu(
                image: "alcohol_3",
                name: "사케3",
                price: 25000),
            Menu(
                image: "alcohol_4",
                name: "살얼음맥주",
                price: 5000),
            Menu(
                image: "alcohol_5",
                name: "테라",
                price: 5000),
            Menu(
                image: "alcohol_6",
                name: "카스",
                price: 5000),
            Menu(
                image: "alcohol_7",
                name: "사케4",
                price: 25000),
            Menu(
                image: "alcohol_8",
                name: "새로",
                price: 5000),
            Menu(
                image: "alcohol_9",
                name: "사케5",
                price: 25000),
            Menu(
                image: "alcohol_10",
                name: "대선",
                price: 5000),
            Menu(
                image: "alcohol_11",
                name: "진로",
                price: 25000),
            Menu(
                image: "alcohol_12",
                name: "사케6",
                price: 25000),
            Menu(
                image: "alcohol_13",
                name: "사케7",
                price: 25000),
            Menu(
                image: "alcohol_14",
                name: "사케9",
                price: 25000),
            Menu(
                image: "alcohol_15",
                name: "사케10",
                price: 25000)
        ],
        "음료": [
            Menu(
                image: "drink_1",
                name: "코카콜라",
                price: 2000),
            Menu(
                image: "drink_2",
                name: "칠성사이다",
                price: 2000),
            Menu(
                image: "drink_3",
                name: "환타",
                price: 2000),
            Menu(
                image: "drink_4",
                name: "토니워터",
                price: 2000),
            Menu(
                image: "drink_5",
                name: "솔의눈",
                price: 2000),
            Menu(
                image: "drink_6",
                name: "깨수깡",
                price: 2000)
        ]
    ]
}
