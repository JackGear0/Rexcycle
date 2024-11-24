//
//  Voucher.swift
//  Rexcycle
//
//  Created by Pedro Catunda on 24/11/24.
//

import Foundation

struct Voucher: Codable, Identifiable {
    var id: UUID
    var title: String
    var description: String
    var purchased_credit: Double
    var createdAt: Date?
    var updatedAt: Date?
    var user_id: UUID
}

extension Voucher {
    struct Create: Encodable {
        var title: String
        var description: String
        var purchasedCredit: Double
    }
}
