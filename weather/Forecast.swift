//
//  Forecast.swift
//  weather
//
//  Created by James Hunt on 11/19/18.
//  Copyright © 2018 James Hunt. All rights reserved.
//

import Foundation


struct Forecast {
    
    
    static let basePath = "https://api.openweathermap.org/data/2.5/"
    static let apiKey = "1a030624be57d904c2ea834c553e9c4c"
    static let weatherType = "forecast?"
    static let units = "imperial"
    static let unit = "F"
    
    
    static func forecast (withID id:String, completion: @escaping
        
        ([[String:Any]]) -> ()) {
        
        var forecastDict = [[String:Any]]()
        
        
        // http://api.openweathermap.org/data/2.5/weather?id=4460162&appid=1a030624be57d904c2ea834c553e9c4c
        
        
        let url = "\(basePath)\(weatherType)id=\(id)&&appid=\(apiKey)&units=\(units)"
        
        print("URL",url)
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            
            var weatherDict = [String:Any]()
            
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        
                        
                        
                        
                        if let stats = json["list"] as? [[String:Any]] {
                           //print("stats",stats)
                            for stat in stats {
                                if let main = stat["main"] as? [String:Any] {
                                    //print("main",main)
                                    if let temp = main["temp"]{
                                        weatherDict["temp"] = temp
                                    }
                                    
                                //print("stat",stat)
                                }
                                if let time = stat["dt_txt"] as? String {
                                    //print("time",time)
                                    weatherDict["time"] = time
                                    //print("stat",stat)
                                }
                                forecastDict.append(weatherDict)
                            }
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                    }
                }catch {
                    print(error.localizedDescription)
                }
                
                completion(forecastDict)
                
            }
            
            
        }
        
        task.resume()
        
        
        
        
        
        
        
        
        
    }
    
    
}


