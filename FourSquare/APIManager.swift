//
//  APIManager.swift
//  FourSquare
//
//  Created by Yasir  on 11/26/21.
//

import Foundation
import UIKit
class APIManager
{
    // MARK: Calling Places Search API
    
    func callPlacesApi(query: String, lat:Double, long:Double,   completion: @escaping (Result<Initial,Error>) -> Void)
    {

        let headers = [
          "Accept": "application/json",
          "Authorization": authKey
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v3/places/search?query=\(query)&ll=\(lat)%2C\(long)&limit=30") as! URL,
                cachePolicy: .useProtocolCachePolicy,
                timeoutInterval: 20.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                print(error)
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do{
                let jsonData = try JSONDecoder().decode(Initial.self,from: data)
            
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }
            catch
            {
                completion(.failure(error))
            }
        })

        dataTask.resume()
      
    }
    
    //MARK: Calling Places Images API
    
    func callImagesApi(fsq_id: String,   completion: @escaping  ([images]) ->()) -> Void
    {

        let headers = [
          "Accept": "application/json",
          "Authorization": authKey
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v3/places/\(fsq_id)/photos") as! URL,
                cachePolicy: .useProtocolCachePolicy,
                timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                print(error)
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do{
                let imagesData = try JSONDecoder().decode([images].self,from: data)
                DispatchQueue.main.async {
                    completion(imagesData)
                }
            }
            catch
            {
               print(error)
            }
        })

        dataTask.resume()
      
    }
    
    //MARK: Calling Places Tips API
    
    func callTipsApi(fsq_id: String,   completion: @escaping  ([Tips]) ->()) -> Void
    {

        let headers = [
          "Accept": "application/json",
          "Authorization": authKey
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v3/places/\(fsq_id)/tips") as! URL,
                cachePolicy: .useProtocolCachePolicy,
                timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                print(error)
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do{
                let placesTips = try JSONDecoder().decode([Tips].self,from: data)
                DispatchQueue.main.async {
                    completion(placesTips)
                }
            }
            catch
            {
               print(error)
            }
        })

        dataTask.resume()
      
    }
    
    // MARK: Calling Places Nearby API
    
    func callNearbyPlacesApi(lat:Double, long:Double,    completion: @escaping (Result<Initial,Error>) -> Void)
    {

        let headers = [
          "Accept": "application/json",
          "Authorization": authKey
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v3/places/nearby?ll=\(lat)%2C\(long)&limit=20")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                print(error)
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do{
                let jsonData = try JSONDecoder().decode(Initial.self,from: data)
            
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }
            catch
            {
                completion(.failure(error))
            }
        })

        dataTask.resume()
      
    }
    

}

