//
//  Bank.swift
//  PagaTodoTest
//
//  Created by Omar Bacilio on 05/06/23.
//

import Foundation

struct Bank: Identifiable, Codable {
    let id: String = UUID().uuidString
    let bankName: String
    let description: String
    let age: Int
    let url: String
}
