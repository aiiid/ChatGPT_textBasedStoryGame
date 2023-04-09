//
//  ApiResponse.swift
//  chatGPT_API
//
//  Created by Ai Hawok on 14/03/2023.
// API Request and Response structure based on official documentation of Chat GPT

import Foundation

struct Choices: Decodable{
    let message: Message
}

struct Message: Decodable{
    let content: String
}
