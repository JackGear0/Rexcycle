//
//  Model.swift
//  Expolog_hackathon
//
//  Created by Layza Maria Rodrigues Carneiro on 23/11/24.
//

import Foundation

enum Material: String, Codable {
    case plastico, metal, vidro, papel
}

struct MaterialID {
    let object: String
    let material: String
    let id: String
}

