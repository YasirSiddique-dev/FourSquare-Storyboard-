//
//  Model.swift
//  FourSquare
//
//  Created by Yasir  on 11/26/21.
//

import Foundation

struct Initial:Codable
{
    let results: [results]
    //let context: context
}

struct results:Codable
{
    let fsq_id:String
    let categories: [categories]
    let chains: [chains]
    let distance: Float
    let name:String
    //let timezone:String
    let geocodes: geocodes
   // let location: location
   
}
struct categories: Codable
{
    let id: Int
    let name:String
    let icon: icon
}
struct icon: Codable
{
    let prefix:String
    let suffix:String
}
struct geocodes:Codable
{
    let main: main
}
//struct location: Codable
//{
//    let country:String
//    let address:String  
//    let dma:String
//    let locality:String
//    let postcode:String
//    let region:String
//  
//    
//}

struct main:Codable
{
    let latitude: Double
    let longitude: Double
}
struct chains: Codable
{
    
}


struct context : Codable
{
    let geo_bounds: geo_bounds
}
struct geo_bounds:Codable
{
    let circle: circle
}
struct circle:Codable
{
    let center: center
    let radius:Int
}
struct center:Codable
{
    let latitude:Float
    let longitude:Float
}
