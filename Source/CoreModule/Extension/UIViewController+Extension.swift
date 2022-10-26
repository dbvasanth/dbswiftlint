//
//  UIViewController+Extension.swift
//  uGlow
//
//  Created by Doodleblue on 01/08/21.
//

import Foundation
import UIKit

extension UIViewController{
    func add(asChildViewController viewController: UIViewController,masterView:UIView) {
        DispatchQueue.main.async {

        // Add Child View Controller
            self.addChild(viewController)
        // Add Child View as Subview
        masterView.addSubview(viewController.view)
        // Configure Child View
        viewController.view.frame = masterView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
        
    }
    func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    //MARK: - Function to show toast
    func showToast(message: String) {
        
        for view in self.view.subviews {
            if view.tag == 1000 {
                view.removeFromSuperview()
            }
        }
        
        guard message.count > 0 else {
            return
        }
        
        let toastContainer = UIView(frame: CGRect())
        toastContainer.tag = 1000
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = 10
        toastContainer.clipsToBounds  =  true
        
        let toastLabel = UILabel(frame: CGRect())
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont.init(name: "Roboto-Medium", size: 15)
        toastLabel.text = message
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        
        toastContainer.addSubview(toastLabel)
        self.view.addSubview(toastContainer)
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 30)
        let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -30)
        let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
        let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
        toastContainer.addConstraints([a1, a2, a3, a4])
        
        let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: self.view, attribute: .leading, multiplier: 1, constant: 40)
        let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -40)
        let c3 = NSLayoutConstraint(item: toastContainer, attribute: .centerY, relatedBy: .lessThanOrEqual, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        let c4 = NSLayoutConstraint(item: toastContainer, attribute: .centerX, relatedBy: .lessThanOrEqual, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        self.view.addConstraints([c1, c2, c3, c4])
        
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 2.0, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: {_ in
                toastContainer.removeFromSuperview()
            })
        })
    }
    
    func resetDefaults() {
        debugPrint("cleared userDefaults data")
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
}

// Timer Handling
protocol CountdownDelegate: AnyObject {
    func countdownDidUpdate(timeRemaining: TimeInterval)
    func countdownDidFinish()
}

extension UIViewController {
    
    var timerDuration: TimeInterval {
        // Convert from minutes + seconds to total seconds
        let minuteString = 0
        let secondString = 60
        
        let minutes = Int(minuteString)
        let seconds = Int(secondString)
        
        let totalSeconds = TimeInterval(minutes * 60 + seconds)
        return totalSeconds
    }
    
    // Enum to track state of countdown
    enum CountdownState {
        case started // countdown is active and counting down
        case finished // countdown has reached 0 and is not active
        case reset // countdown is at initial time value and not active
    }
    
    class Countdown {
        
        // used to inform delegate of countdown's current state
        // and when countdown has finished
        weak var delegate: CountdownDelegate?
        
        // number of seconds; countdown's starting value
        var duration: TimeInterval
        
        // derived number of seconds remaining when the countdown is active
        var timeRemaining: TimeInterval {
            if let stopDate = stopDate {
                let timeRemaining = stopDate.timeIntervalSinceNow
                return timeRemaining
            } else {
                return 0
            }
        }
        
        // has value only when countdown is active
        // waits a specific period and fires a method on an recurring interval
        private var timer: Timer?
        
        // has value only when countdown is active
        // future date; determines when timer should stop
        private var stopDate: Date?
        
        // current state of countdown
        private(set) var state: CountdownState
        
        init() {
            timer = nil
            stopDate = nil
            duration = 0
            state = .reset
        }
        
        func start() {
            // Cancel timer before starting new timer
            cancelTimer()
            timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true, block: updateTimer(timer:))
            stopDate = Date(timeIntervalSinceNow: duration)
            state = .started
        }
        
        func reset() {
            stopDate = nil
            cancelTimer()
            state = .reset
        }
        
        func cancelTimer() {
            // We must invalidate a timer, or it will continue to run even if we
            // start a new timer
            timer?.invalidate()
            timer = nil
        }
        
        // called each time the timer object fires
        // (300 times per second in this app)
        private func updateTimer(timer: Timer) {
            if let stopDate = stopDate {
                let currentTime = Date()
                if currentTime <= stopDate {
                    // Timer is active, keep counting down
                    delegate?.countdownDidUpdate(timeRemaining: timeRemaining)
                } else {
                    // Timer is finished, reset and stop counting down
                    state = .finished
                    cancelTimer()
                    self.stopDate = nil
                    delegate?.countdownDidFinish()
                }
            }
        }
    }
}


func getDateValue(val:String,format:String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    let data = dateFormatter.date(from: val) ?? Date()
    let dateFormatterUpdate = DateFormatter()
    dateFormatterUpdate.locale = Locale(identifier: "en_US_POSIX")
    dateFormatterUpdate.dateFormat = format
    return data
}
func getCustomDate(date:Date,format:String) -> String? {
    let dateFormatterUpdate = DateFormatter()
    dateFormatterUpdate.locale = Locale(identifier: "en_US_POSIX")
    dateFormatterUpdate.dateFormat = format
    return dateFormatterUpdate.string(from:date)
}
func getDate(val:String,currentFormat:String,format:String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = currentFormat
    //        dateFormatter.timeZone = TimeZone.current
    //        dateFormatter.locale = Locale.current
    let data = dateFormatter.date(from: val) ?? Date()
    
    let dateFormatterUpdate = DateFormatter()
    dateFormatterUpdate.locale = Locale(identifier: "en_US_POSIX")
    dateFormatterUpdate.dateFormat = format
    return dateFormatterUpdate.string(from:data)
}
func utcToLocal(dateStr: String,currentFormat:String,expectedFormat:String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = currentFormat
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    if let date = dateFormatter.date(from: dateStr) {
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = expectedFormat
    
        return dateFormatter.string(from: date)
    }
    return nil
}
//Root Navigation Set
func getNavigationInstance<Element>(vc:Element) -> UINavigationController {
    if let v = vc as? UIViewController{
        let navigationController = UINavigationController.init(rootViewController: v )
        navigationController.navigationBar.isHidden = true
        return navigationController
        
    }else{
        return UINavigationController()
    }
    
}
func format(with mask: String, phone: String) -> String {
    let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    var result = ""
    var index = numbers.startIndex // numbers iterator

    // iterate over the mask characters until the iterator of numbers ends
    for ch in mask where index < numbers.endIndex {
        if ch == "X" {
            // mask requires a number in this place, so take the next one
            result.append(numbers[index])

            // move numbers iterator to the next index
            index = numbers.index(after: index)

        } else {
            result.append(ch) // just append a mask character
        }
    }
    return result
}
