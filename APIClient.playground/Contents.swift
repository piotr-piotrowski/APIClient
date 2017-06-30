//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let todoEndpoint = "https://jsonplaceholder.typicode.com/todos/1"

if let url = URL(string: todoEndpoint) {
    let session = URLSession(configuration: URLSessionConfiguration.default)
    session.dataTask(with: URLRequest(url: url)) { (data, response, error) -> Void in
        if let data = data {
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
            if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                let title = json??["title"] as! String
                print("\(title)")
            } else {
                print("there was an error")
            }
        }
    }.resume()
    
} else {
    print("Error: cannot create URL")
}

enum JSONError: String, Error {
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}

func jsonParser() {
    let url = "https://jsonplaceholder.typicode.com/todos/1"
    guard let endpoint = URL(string: url) else {
        print("Error creating endpoint")
        return
    }
    URLSession.shared.dataTask(with: endpoint) { (data, response, error) in
        do {
            guard let data = data else {
                throw JSONError.NoData
            }
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                throw JSONError.ConversionFailed
            }
            print(json)
        } catch let error as JSONError {
            print(error.rawValue)
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }.resume()
}

jsonParser()
