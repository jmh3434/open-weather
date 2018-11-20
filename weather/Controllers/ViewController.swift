//
//  ViewController.swift
//  weather
//
//  Created by James Hunt on 11/18/18.
//  Copyright © 2018 James Hunt. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let weatherLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    let iconContainer = UIView()
    let icon = UIView()
    
    
    var labelCurrent = UILabel()
    var labelSummary = UILabel()
    var labelHigh = UILabel()
    var labelLow = UILabel()
    
    var tempLows = [Double]()
    var tempHighs = [Double]()
    var weekDays = [String]()
    var icons = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // label for Title
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
        titleLabel.numberOfLines = 5
        titleLabel.text = "Chapel Hill Weather"
        titleLabel.center = CGPoint(x: 130, y: 118)
        titleLabel.textAlignment = .justified
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "Dosis-Bold", size: 35)
        self.view.addSubview(titleLabel)
        
        //label for time, windspeed, and humidity
        weatherLabel.numberOfLines = 112
        weatherLabel.center = CGPoint(x: 180, y: 280)
        weatherLabel.textAlignment = .natural
        weatherLabel.textColor = UIColor.black
        weatherLabel.font = UIFont(name: "Dosis-Light", size: 26)
        self.view.addSubview(weatherLabel)
        
        getLocation()
        
        
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        
        self.iconContainer.frame = CGRect(x: 60, y: 60, width: 200, height: 200)
        self.view.addSubview(iconContainer)
        
        
        self.icon.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        
        let weatherIcon = UIImageView()
        weatherIcon.image = UIImage(named: "icon_weather.png")
        weatherIcon.frame = CGRect(x: 180, y: 160, width: 100, height: 100)
        self.icon.addSubview(weatherIcon)
        
        
        
        
        self.iconContainer.addSubview(self.icon)
        UIView.animate(withDuration: 1.5, animations: {
            self.icon.frame.origin.y -= 160
        }, completion: nil)
        
        
        
        // label for low temp
        labelLow = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        labelLow.numberOfLines = 112
        labelLow.center = CGPoint(x: 180, y: 420)
        labelLow.textAlignment = .center
        labelLow.textColor = UIColor(red:0.35, green:0.56, blue:0.96, alpha:1.0)
        labelLow.font = UIFont(name: "Dosis-Light", size: 30)
        self.view.addSubview(labelLow)
        
        
        //label for current temp
        labelCurrent = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        labelCurrent.numberOfLines = 112
        labelCurrent.center = CGPoint(x: 180, y: 460)
        labelCurrent.textAlignment = .center
        labelCurrent.textColor = UIColor.black
        labelCurrent.font = UIFont(name: "Dosis-Light", size: 30)
        self.view.addSubview(labelCurrent)
        
        // label for max temp
        labelHigh = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        labelHigh.numberOfLines = 112
        labelHigh.center = CGPoint(x: 180, y: 500)
        labelHigh.textAlignment = .center
        labelHigh.textColor = UIColor.red
        labelHigh.font = UIFont(name: "Dosis-Light", size: 30)
        self.view.addSubview(labelHigh)
        
        
        
        // label for weather summary this week
        
        labelSummary = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        labelSummary.numberOfLines = 112
        labelSummary.center = CGPoint(x: 180, y: 600)
        labelSummary.textAlignment = .center
        labelSummary.textColor = UIColor.black
        labelSummary.font = UIFont(name: "Dosis-Light", size: 30)
        self.view.addSubview(labelSummary)
        
        // buttton
        
        
    }
    func getLocation() {
        
    
        Forecast.getWeather(withLocation: "35.9467,-79.0612") { (array:[[String:Any]]) in
            
            
            DispatchQueue.main.async {
                for date in array {
                    
                    let time = date["time"] as! Int
                    var icon = date["icon"] as! String
                    
                    switch icon {
                        case "clear-day": icon = "clear"
                        case "partly-cloudy-night": icon = "partly cloudy"
                        case "partly-cloudy-day": icon = "partly cloudy"
                        case "rain": icon = "rain"
                        
                    
                    default: icon = "nil"
                    }
                    
                    let unixTimestamp = time
                    let day = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.timeZone = TimeZone(abbreviation: "EDT") //Set timezone that you want
                    dateFormatter.locale = NSLocale.current
                    dateFormatter.dateFormat = "EEEE" //Specify your format that you want
                    let strDate = dateFormatter.string(from: day)

                    //print("day??",strDate)
                    self.tempLows.append(date["tempLow"] as! Double)
                    self.tempHighs.append(date["tempHigh"] as! Double)
                    self.weekDays.append(strDate )
                    self.icons.append(icon)
                    
                    
                    self.collectionView.reloadData()
                    
                }
                
            }
            
            
        }
        Summary.getWeather(withLocation: "35.9467,-79.0612") { (currentWeather:[String : Any]) in
            DispatchQueue.main.async {
                let temp = currentWeather["temp"] as! Double
                let humidity = currentWeather["humidity"] as! Double
                let time = currentWeather["time"] as! Int
                let cloudCover = currentWeather["cloudCover"] as! Double
                let windSpeed = currentWeather["windSpeed"] as! Double
                let precipProbability = currentWeather["precipProbability"] as! Double
                let nearestStormDistance = currentWeather["nearestStormDistance"] as! Int
                let summary = currentWeather["summary"] as! String
                let tempLow = currentWeather["tempLow"] as! Double
                let tempHigh = currentWeather["tempHigh"] as! Double

                
                
                
                let unixTimestamp = time
                let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
                
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(abbreviation: "EDT") //Set timezone that you want
                dateFormatter.locale = NSLocale.current
                dateFormatter.dateFormat = "MM-dd h:mm" //Specify your format that you want
                let strDate = dateFormatter.string(from: date)
                
                
                
                
                self.weatherLabel.text = "time: \(strDate)\nwindspeed: \(windSpeed) MPH\nhumidity: \(Int(humidity*100))%\nnearest storm: \(nearestStormDistance) miles\ncloud cover: \(cloudCover)%\nprecipitation probability: \(precipProbability)%"
                
                
                self.labelHigh.text = "\(tempHigh) ˚F"
                self.labelCurrent.text = "\(temp) ˚F"
                self.labelLow.text = "\(tempLow) ˚F"
                self.labelSummary.text = summary

                
            }
        }
        
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("hey")
        getLocation()
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        switch icons[indexPath.row] {
        case "clear": cell.cvImage.image = UIImage(named: "clear.png")
        case "partly cloudy": cell.cvImage.image = UIImage(named: "partly-cloudy.png")
        case "rain": cell.cvImage.image = UIImage(named: "rain.png")
        default:
            cell.cvImage.image = UIImage(named: "clear.png")
        }
        cell.label.text = "\(weekDays[indexPath.row])\n\(icons[indexPath.row])"
        cell.highlowLabel.text = "\(tempLows[indexPath.row])˚F \u{2193}\n\(tempHighs[indexPath.row])˚F \u{2191}"
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempLows.count
    }

}

extension NSDate {
    func dayOfTheWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self as Date)
    }
}
