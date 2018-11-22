//
//  Minutely.swift
//  weather
//
//  Created by James Hunt on 11/22/18.
//  Copyright © 2018 James Hunt. All rights reserved.
//

import Foundation


struct Hourly {
    
    
    static let basePath = "https://api.darksky.net/forecast/efd21cf614c4f0429e807683bbe7b1e4/"
    static let apiKey = "1a030624be57d904c2ea834c553e9c4c"
    static let weatherType = "weather?"
    static let units = "imperial"
    static let unit = "F"
    
    
    static func getWeather (withLocation location:String, completion: @escaping
        
        ([[String:Any]]) -> ()) {
        
        
        var i = 0
        let url = basePath + location
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            var weatherArray = [[String:Any]]()
            var weatherDict = [String:Any]()
            
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        
                        
                        
                        
                        if let dailyOutlook = json["hourly"] as? [String:Any] {
                            
                            
                            
                            if let dailyOutlook = dailyOutlook["data"] as? [[String:Any]] {
                                
                                
                                
                                
                                for dataPoint in dailyOutlook {
                                    if let time = dailyOutlook[i]["time"], let temperature = dailyOutlook[i]["temperature"]{
                                        
                                        weatherDict["time"] = time
                                        
                                        weatherDict["temperature"] = temperature
                                        
                                        
                                        
                                
                                        i+=1
                                        
                                    }
                                    //print("dataPoint",dataPoint)
                                    weatherArray.append(weatherDict)
                                }
                            }
                        }
                        
                        
                    }
                }catch {
                    print(error.localizedDescription)
                }
                
                completion(weatherArray)
                
            }
            
            
        }
        
        task.resume()
        
        
        
        
        
        
        
        
        
    }
    
    
}


