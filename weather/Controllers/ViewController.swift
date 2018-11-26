//
//  ViewController.swift
//  weather
//
//  Created by James Hunt on 11/18/18.
//  Copyright © 2018 James Hunt. All rights reserved.
//

import UIKit
import Charts


class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var collectionViewA: UICollectionView!
    @IBOutlet weak var collectionViewB: UICollectionView!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var tempButton: UIButton!
    
    
    let iconContainer = UIView()
    let tempView = UIView()
    let icon = UIView()
    
    
    
    
    var labelSummary = UILabel()
    
    var labelHigh = UILabel()
    var labelLow = UILabel()
    var labelCurrent = UILabel()
    
    @IBOutlet weak var moonLabel: UILabel!
    
    var tempHigh = Double()
    var tempLow = Double()
    var temp = Double()
    var moonPhase = String()
    var temps = [Int]()
    var hours = [String]()
    var tempLows = [Int]()
    var tempHighs = [Int]()
    var weekDays = [String]()
    var icons = [String]()
    let moonIcon = UIImageView()
    let shapeLayer = CAShapeLayer()
    let weatherIcon = UIImageView()
    var moonHidden = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moonLabel.textColor = UIColor(red:0.35, green:0.56, blue:1.0, alpha:1.0)
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 300,y: 320), radius: CGFloat(52), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        
        shapeLayer.path = circlePath.cgPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.black.cgColor
        
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor(red:0.35, green:0.56, blue:1.0, alpha:1.0).cgColor
        //you can change the line width
        shapeLayer.lineWidth = 3.0
        
        view.layer.addSublayer(shapeLayer)
        
        
        
        
       
        collectionViewA.backgroundColor = UIColor(white: 0.9, alpha: 1)
        collectionViewB.backgroundColor = UIColor(white: 0.9, alpha: 1)
        collectionViewA.delegate = self
        collectionViewB.delegate = self
        
        collectionViewA.dataSource = self
        collectionViewB.dataSource = self
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
    
        
        getLocation()
        
        
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        
        self.iconContainer.frame = CGRect(x: 60, y: 60, width: 200, height: 200)
        self.view.addSubview(iconContainer)
        
        self.tempView.frame = CGRect(x: 0, y: 375, width: 600, height: 55)
        //self.view.addSubview(tempView)
        tempView.backgroundColor = UIColor.black
        
        
        self.icon.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        
        
        
        weatherIcon.image = UIImage(named: "icon_weather.png")
        weatherIcon.frame = CGRect(x: 180, y: 160, width: 100, height: 100)
        self.icon.addSubview(weatherIcon)
        
        
        
        moonIcon.frame = CGRect(x: 250, y: 270, width: 100, height: 100)
        
        self.view.addSubview(moonIcon)
        
        
        
        
        self.iconContainer.addSubview(self.icon)
        UIView.animate(withDuration: 1.5, animations: {
            self.icon.frame.origin.y -= 160
        }, completion: nil)
        
        
        
        
        
        // label for weather summary this week
        
        labelSummary = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        labelSummary.numberOfLines = 112
        labelSummary.center = CGPoint(x: 200, y: 200)
        labelSummary.textAlignment = .center
        labelSummary.textColor = UIColor.darkGray
        labelSummary.font = UIFont(name: "Dosis-Light", size: 22)
        self.view.addSubview(labelSummary)
        
        // buttton
        
        
    }
    func getLocation() {
        
        Hourly.getWeather(withLocation: "35.9467,-79.0612") { (hours:[[String:Any]]) in
            
            
            DispatchQueue.main.async {
                for hour in hours {
                    
                    let time = hour["time"] as! Int
                    let tempDouble = hour["temperature"] as! Double
                    
                    let temperature = Int(tempDouble)
                    
              
                    
                    let unixTimestamp = time
                    let day = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.timeZone = TimeZone(abbreviation: "EDT") //Set timezone that you want
                    dateFormatter.locale = NSLocale.current
                    
                    
                    dateFormatter.dateFormat = "h a"
                    dateFormatter.amSymbol = "AM"
                    dateFormatter.pmSymbol = "PM"
                    
                    let strDate = dateFormatter.string(from: day)
                    
                    
                    
                    print("Hour ",strDate)
                    print("Temp: ",temperature)
                    self.hours.append(strDate)
                    self.temps.append(temperature)
                    self.collectionViewB.reloadData()
                }
                
            }
            
            
        }
        Forecast.getWeather(withLocation: "35.9467,-79.0612") { (array:[[String:Any]]) in
            
            
            DispatchQueue.main.async {
                for date in array {
                    
                    let time = date["time"] as! Int
                    var icon = date["icon"] as! String
                    print("icon",icon)
                    
                    switch icon {
                        case "clear-day": icon = "clear"
                        case "partly-cloudy-night": icon = "partly cloudy"
                        case "partly-cloudy-day": icon = "partly cloudy"
                        case "rain": icon = "rain"
                        case "wind": icon = "rain"
                        case "snow": icon = "snow"
                        case "fog": icon = "fog"
                        case "cloudy": icon = "cloudy"
                        
                    
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
                    let lowDouble = date["tempLow"] as! Double
                    let highDouble = date["tempHigh"] as! Double
                    //let moonPhase = date["moonPhase"] as! Double
                    let low = Int(lowDouble)
                    let high = Int(highDouble)
                    
                    self.tempLows.append(low)
                    self.tempHighs.append(high)
                    self.weekDays.append(strDate )
                    self.icons.append(icon)
                    //print("moon Phase is:",moonPhase)
                    
                    
                    self.collectionViewA.reloadData()
                    
                }
                
            }
            
            
        }
        Summary.getWeather(withLocation: "35.9467,-79.0612") { (currentWeather:[String : Any]) in
            DispatchQueue.main.async {
                self.temp = currentWeather["temp"] as! Double
                let newTemp = Int(self.temp)
                let humidity = currentWeather["humidity"] as! Double
                let time = currentWeather["time"] as! Int
                let cloudCover = currentWeather["cloudCover"] as! Double
                let windSpeed = currentWeather["windSpeed"] as! Double
                let precipProbability = currentWeather["precipProbability"] as! Double
                let nearestStormDistance = currentWeather["nearestStormDistance"] as! Int
                let summary = currentWeather["summary"] as! String
                self.tempLow = currentWeather["tempLow"] as! Double
                self.tempHigh = currentWeather["tempHigh"] as! Double
                let apparentTemperature = currentWeather["apparentTemperature"] as! Double
                let moonPhaseValue = currentWeather["moonPhase"] as! Double

                self.moonPhase = self.getMoonPhase(value: moonPhaseValue)
                
                
                let unixTimestamp = time
                let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
                
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(abbreviation: "EDT") //Set timezone that you want
                dateFormatter.locale = NSLocale.current
                dateFormatter.dateFormat = "h:mm a" //Specify your format that you want
                let strDate = dateFormatter.string(from: date)
                
                
                
                
                self.weatherLabel.text = "time: \(strDate)\nwindspeed: \(windSpeed) MPH\nhumidity: \(Int(humidity*100))%\nnearest storm: \(nearestStormDistance) miles\n\ncloud cover: \(cloudCover)%\nprecipitation probability: \(precipProbability)%\nfeels like: \(Int(apparentTemperature))˚"
                
                
                
                
                
                self.labelLow = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
                self.labelLow.numberOfLines = 112
                self.labelLow.center = CGPoint(x: 300, y: 300)
                self.labelLow.textAlignment = .center
                let alphaL = (self.tempLow-25) * 0.033
                self.labelLow.textColor = UIColor(red:0.35, green:0.56, blue:1.0, alpha:CGFloat(alphaL))
                
                self.labelLow.font = UIFont(name: "Dosis-Bold", size: 20)
                self.view.addSubview(self.labelLow)
                
                
                //label for current temp
                self.labelCurrent = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
                self.labelCurrent.numberOfLines = 112
                self.labelCurrent.center = CGPoint(x: 300, y: 320)
                self.labelCurrent.textAlignment = .center
                
                
                self.labelCurrent.font = UIFont(name: "Dosis-Bold", size: 20)
                let alphaC = (self.temp-25) * 0.033
                self.labelCurrent.textColor = UIColor(red:0.35, green:0.56, blue:1.0, alpha:CGFloat(alphaC))
                self.view.addSubview(self.labelCurrent)
                
                // label for max temp
                self.labelHigh = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
                self.labelHigh.numberOfLines = 112
                self.labelHigh.center = CGPoint(x: 300, y: 340)
                self.labelHigh.textAlignment = .center
                let alphaH = (self.tempHigh-25) * 0.033
                self.labelHigh.textColor = UIColor(red:0.35, green:0.56, blue:1.0, alpha:CGFloat(alphaH))
                
                self.labelHigh.font = UIFont(name: "Dosis-Bold", size: 20   )
                self.view.addSubview(self.labelHigh)
                
                print("temps ",self.temp,self.tempLow,self.tempHigh)
                self.labelHigh.text = "\(self.tempHigh)˚"
                self.labelCurrent.text = "\(newTemp)˚"
                self.labelLow.text = "\(self.tempLow)˚"
                self.labelSummary.text = summary
                
            }
        }
        
        
    }
    func getMoonPhase(value:Double)->String{
        var phase = String()
        if value == 0 {
            phase = "\(value) new"
            moonIcon.image = UIImage(named: "new-moon")
        } else if value > 0 && value < 0.25 {
            phase = "\(value) waxing crescent"
            moonIcon.image = UIImage(named: "waxing-crescent")
        } else if value == 0.25 {
            phase = "\(value) first quarter"
            moonIcon.image = UIImage(named: "first-quarter")
        } else if value > 0.25 && value < 0.5 {
            phase = "\(value) waxing gibbous"
            moonIcon.image = UIImage(named: "waxing-gibbous")
        } else if value == 0.5 {
            phase = "\(value) full"
            moonIcon.image = UIImage(named: "full-moon")
        } else if value > 0.5 && value < 0.75 {
            phase = "\(value) waning gibbous"
            moonIcon.image = UIImage(named: "waning-gibbous")
        } else if value == 0.75 {
            phase = "\(value) last quarter"
            moonIcon.image = UIImage(named: "last-quarter")
        } else {
            phase = "\(value) waning crescent"
            moonIcon.image = UIImage(named: "waning-crescent")
            
        }
        return phase
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("hey")
        getLocation()
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionViewA {
            
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
            
            switch icons[indexPath.row] {
                case "clear": cellA.cvImage.image = UIImage(named: "clear.png")
                case "partly cloudy": cellA.cvImage.image = UIImage(named: "partly-cloudy.png")
                case "rain": cellA.cvImage.image = UIImage(named: "rain.png")
                case "snow": cellA.cvImage.image = UIImage(named: "snow.png")
                case "fog": cellA.cvImage.image = UIImage(named: "fog.png")
            case "cloudy": cellA.cvImage.image = UIImage(named: "cloudy.png")
            default:
                
                cellA.cvImage.image = UIImage(named: "clear.png")
            }
            cellA.label.text = "\(weekDays[indexPath.row])\n\(icons[indexPath.row])"
            cellA.highlowLabel.text = "\(tempLows[indexPath.row]) ˚F \u{2193}\n\(tempHighs[indexPath.row]) ˚F \u{2191}"
            
            if indexPath.row % 2 == 0 {
                cellA.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.82)
                cellA.highlowLabel.textColor = UIColor.white
                cellA.label.textColor = UIColor.white
                
            } else {
                cellA.label.textColor = UIColor.white
                cellA.highlowLabel.textColor = UIColor.white
                cellA.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.89)
            }
            
            return cellA
       
        }
            
        else {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "temp", for: indexPath) as! TempCell
            
            cellB.tempLabel.text = "\(temps[indexPath.row]) ˚F"
            cellB.timeLabel.text = "\(hours[indexPath.row])"
            print("hourscount",hours.count)
//            if indexPath.row % 2 == 0 {
//                cellB.backgroundColor = UIColor.lightGray
//            } else {
//                cellB.backgroundColor = UIColor.white
//            }
            let currentCellTemp = Double(temps[indexPath.row]-25)
            print("currentCellTemp",currentCellTemp)
            let alphaV = currentCellTemp * 0.033
            cellB.backgroundColor = UIColor(red:0.35, green:0.56, blue:1.0, alpha:CGFloat(alphaV))
            
            return cellB
        }
       
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionViewA {
            return tempLows.count // Replace with count of your data for collectionViewA
        }
        
        return hours.count
        
    }

    @IBAction func tempButtonPress(_ sender: Any) {
        
        if moonHidden {
            
            moonIcon.isHidden = false
            shapeLayer.fillColor = UIColor.white.cgColor
            moonLabel.isHidden = false
            moonLabel.layer.zPosition = 3
            moonLabel.text = "\(moonPhase)"
            labelLow.isHidden = true
            labelCurrent.isHidden = true
            labelHigh.isHidden = true
            
            shapeLayer.strokeColor = UIColor.lightGray.cgColor
            
            moonHidden = false
            
            
        }else{
            
            shapeLayer.fillColor = UIColor.white.cgColor
            moonIcon.isHidden = true
            moonLabel.isHidden = true
            labelLow.isHidden = false
            labelCurrent.isHidden = false
            labelHigh.isHidden = false
            shapeLayer.strokeColor = UIColor(red:0.35, green:0.56, blue:1.0, alpha:1.0).cgColor
            moonHidden = true
            
        }
    }
}

extension NSDate {
    func dayOfTheWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self as Date)
    }
}
