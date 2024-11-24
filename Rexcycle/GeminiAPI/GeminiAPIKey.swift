//
//  Untitled.swift
//  expologHackGeminiPOC
//
//  Created by Yago Souza Ramos on 11/23/24.
//

import Foundation

enum APIKey {
    // Fetch the API key from `GenerativeAI-Info.plist`
    static var `default`: String {
        let key: String = "Key\([1, 2, 3].randomElement()!)"

        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist")
        else {
            fatalError("Couldn't find file 'GenerativeAI-Info.plist'.")
        }
        print("\(key)")
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "\(key)") as? String else {
            fatalError("Couldn't find key \(key) in 'GenerativeAI-Info.plist'.")
        }
        if value.starts(with: "_") {
            fatalError(
                "Follow the instructions at https://ai.google.dev/tutorials/setup to get an API key."
            )
        }
        return value
    }
}

