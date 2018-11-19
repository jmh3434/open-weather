//
//  ViewController.swift
//  weather
//
//  Created by James Hunt on 11/18/18.
//  Copyright © 2018 James Hunt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getLocation()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func getLocation() {
        
        Weather.forecast(withID: "4460162") { (data:[String:Any]) in
            
                
                DispatchQueue.main.async {
//                    let temp = result.temp
//                    print("the temperature is", temp)
                    
//                    let humidity = data["humidity"]!
//                    print("the humidity from here is is", humidity)
//                    let description = data["description"]!
//                    print("the description from here is is", description)
//                    let main = data["main"]!
//                    print("the main from here is is", main)
//                    let temp = data["temp"]!
//
//                    print("temp is:", temp)
//                    let temp_max = data["temp_max"]
//                    print("temp_max",temp_max ?? 0)
//                    let temp_min = data["temp_min"]
//                    print("temp_min",temp_min ?? 0)
//                    let windspeed = data["windspeed"]!
//                    print("windspeed",windspeed)
                }
            
            
        }
        Forecast.forecast(withID: "4460162") { (forecastDict:[[String:Any]]) in
            
            
            DispatchQueue.main.async {
                for day in forecastDict {
                    //print("day",day)
                }
            }
            
            
        }
        Summary.getWeather(withLocation: "35.9467,-79.0612") { (currentWeather:[String : Any]) in
            DispatchQueue.main.async {
                print(currentWeather["temp"])
                
            }
        }
        
        
    }
    
        
    
    

}


