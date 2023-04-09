//
//  ConfigManager.swift
//  chatGPT_API
//
//  Created by Ai Hawok on 05/04/2023.
//
// ConfigManager created to get apiKey from config.plist


import Foundation

class ConfigManager {
    static let shared = ConfigManager()
    private var apiKey: String?

    private init() {
        guard let path = Bundle.main.path(forResource: "config", ofType: "plist") else {
            fatalError("Unable to find config.plist")
        }

        let url = URL(fileURLWithPath: path)

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Unable to load config.plist")
        }

        guard let plist = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String: Any] else {
            fatalError("Unable to parse config.plist")
        }

        self.apiKey = plist["apiKey"] as? String
    }

    func getAPIKey() -> String {
        guard let apiKey = self.apiKey else {
            fatalError("API key not found in config.plist")
        }

        return apiKey
    }
}
