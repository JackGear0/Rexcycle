//
//  API.swift
//  Rexcycle
//
//  Created by Pedro Catunda on 24/11/24.
//

import Foundation
import UIKit
import Compression

// Endereço local do host da API
private let baseURL = "http://192.168.1.37:8080/"

/// Retorna erros específicos
enum APIRequestError: Error {
    case requestError
}
enum APISpecifiedError: Error {
    case apiError(code: Int, body: Data?)
}
enum DataError: Error {
    case dataError
}

enum API {
    
    /// Verifica o status code da response da API
    static func check(data: Data?, response: URLResponse) throws {
        if let response = response as? HTTPURLResponse {
            switch response.statusCode {
            case 200..<300:
                print("😸 Sucesso! \(response.statusCode)")
            default:
                print("🙀 Erro \(response.statusCode)")
                throw APISpecifiedError.apiError(code: response.statusCode, body: data)
            }
        }
    }
    
    /// Retorna um usuário específico pelo seu ID
    static func getUser(userID: UUID) async throws -> User {
        let userPath = baseURL.appending("users/\(userID.uuidString)")
        let userURL = URL(string: userPath)!
        do {
            let (data, _) = try await URLSession.shared.data(from: userURL)
            return try JSONDecoder().decode(User.self, from: data)
        } catch { throw APIRequestError.requestError }
    }
    
    static func getUsers() async throws -> [User] {
        let usersPath = baseURL.appending("users")
        let usersURL = URL(string: usersPath)!
        let (data, response) = try await URLSession.shared.data(from: usersURL)
        try check(data: data, response: response)
        return try JSONDecoder().decode([User].self, from: data)
    }

    static func createUser(username: String, name: String?, avatar: UIImage?, password: String, isEnterprise: Bool = false) async throws {
        let url = baseURL.appending("users")
        
        let avatarString = avatar.flatMap { convertImageToBase64String(img: $0) }
        let newUser = User.Create(username: username, name: name, avatar: avatarString, password: password, isEnterprise: isEnterprise)
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(newUser)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        try check(data: data, response: response)
    }
    
    static func updateCredits(credits: Double) async throws {
        let url = baseURL.appending("users/credits")
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            throw NSError(domain: "Token não encontrado", code: -1, userInfo: nil)
        }

        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["credit": credits]
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

        let (data, response) = try await URLSession.shared.data(for: request)

        try check(data: data, response: response)

        print("Créditos atualizados com sucesso!")
    }

    /// Faz login do usuário e retorna seu token de acesso caso login aceito
    static func login(username: String, password: String) async throws {
        let url = baseURL.appending("users/login")
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        
        let auth = (username + ":" + password).data(using: .utf8)!.base64EncodedString()
        
        request.setValue("Basic \(auth)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        try check(data: data, response: response)
        
        let session = try JSONDecoder().decode(Session.self, from: data)
        
        UserDefaults.standard.set(session.token, forKey: "token")
    }
    
    /// Faz o logout do usuário e retorna o token de desconexão
    static func logout() async throws {
        let url = baseURL.appending("users/logout")
        let token = UserDefaults.standard.string(forKey: "token")!
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        try check(data: data, response: response)
        
        let session = try JSONDecoder().decode(Session.self, from: data)
        
        UserDefaults.standard.set("", forKey: "token")
    }
    
    static func me() async throws -> User {
        let url = baseURL.appending("users/me")
        let token = UserDefaults.standard.string(forKey: "token")!

        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: request)
        try check(data: data, response: response)
        let user = try JSONDecoder().decode(User.self, from: data)
        return user
    }
    
    static func getVouchers() async throws -> [Voucher] {
        let vouchersPath = baseURL.appending("posts")
        guard let vouchersURL = URL(string: vouchersPath) else {
            throw APIRequestError.requestError
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: vouchersURL)
            try check(data: data, response: response)

            // Log do JSON recebido
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON recebido: \(jsonString)")
            }

            return try JSONDecoder().decode([Voucher].self, from: data)
        } catch {
            print("Erro detalhado ao carregar posts: \(error)")
            throw APIRequestError.requestError
        }
    }
    
    static func createVoucher(title: String, description: String, purchasedCredit: Double) async throws {
        let url = baseURL.appending("posts")
        let token = UserDefaults.standard.string(forKey: "token")!
        
        let newVoucher = Voucher.Create(title: title, description: description, purchasedCredit: purchasedCredit)
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(newVoucher)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        try check(data: data, response: response)
    }
}

extension API {
    
    /// UIImage to Bas64String
    static func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    /// Bas64String to UIImage
    static func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data(base64Encoded: imageBase64String)
        let image = UIImage(data: imageData!)
        return image!
    }
    
    /// Data to Bas64String
    static func convertDataToString (data: Data) -> String {
        return data.base64EncodedString()
    }
    
    /// Bas64String to Data
    static func convertStringToData (string: String) -> Data {
        return Data(base64Encoded: string)!
    }
    
    /// Salva um Data temporariamente e retorna uma URL se conseguiu sem erro
    static func saveDataToTemporaryFile(data: Data) -> URL? {
        let tempDirectory = FileManager.default.temporaryDirectory
        let tempFileURL = tempDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("mp4")
        
        do {
            try data.write(to: tempFileURL)
            return tempFileURL
        } catch {
            print("Erro ao salvar o arquivo: \(error)")
            return nil
        }
    }
    
    /// Comprime um Data
    static func compressData(_ data: Data) -> Data? {
        return data.withUnsafeBytes { (rawBufferPointer) -> Data? in
            guard let baseAddress = rawBufferPointer.baseAddress else { return nil }
            let sourceBuffer = UnsafeBufferPointer<UInt8>(start: baseAddress.assumingMemoryBound(to: UInt8.self), count: data.count)
            
            let destinationBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: data.count)
            let compressedSize = compression_encode_buffer(destinationBuffer, data.count, sourceBuffer.baseAddress!, sourceBuffer.count, nil, COMPRESSION_ZLIB)
            
            if compressedSize == 0 {
                return nil
            }
            
            return Data(bytes: destinationBuffer, count: compressedSize)
        }
    }

    /// Descomprime um Data comprimido
    static func decompressData(_ data: Data) -> Data? {
        return data.withUnsafeBytes { (rawBufferPointer) -> Data? in
            guard let baseAddress = rawBufferPointer.baseAddress else { return nil }
            let sourceBuffer = UnsafeBufferPointer<UInt8>(start: baseAddress.assumingMemoryBound(to: UInt8.self), count: data.count)
            
            let destinationBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: data.count * 4)
            let decompressedSize = compression_decode_buffer(destinationBuffer, data.count * 4, sourceBuffer.baseAddress!, sourceBuffer.count, nil, COMPRESSION_ZLIB)
            
            if decompressedSize == 0 {
                return nil
            }
            
            return Data(bytes: destinationBuffer, count: decompressedSize)
        }
    }

    /// Prepara para enviar media ao
    static func prepareToSendMedia(data: Data) throws -> String {
        let data = compressData(data)!
        return convertDataToString(data: data)
    }
    
    /// Prepara para receber media do backend, retorna a URL temporária
    static func prepareToReceiveMedia(string: String) throws -> URL? {
        let string = convertStringToData(string: string)
        let data = decompressData(string)!
        return saveDataToTemporaryFile(data: data)
    }
}
