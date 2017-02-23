//  Orientation
//
//  Created by Shady Ghalab on 23/02/2017.
//  Copyright © 2017 Shady Ghalab. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion
import AVFoundation

class OrientionProvider: NSObject {
    
    var motionManager: CMMotionManager = CMMotionManager()
    
    override init() {
        super.init()
        setupMotionManger()
    }
    
    // MARK: Actual orientation
    func orientation() -> UIDeviceOrientation? {
        return actualDeviceOrientationFromAccelerometer()
    }
    
    func deviceOrientationMatchesInterfaceOrientation() -> Bool {
        return orientation() == UIDevice.current.orientation
    }
    
    // MARK: Private
    private func setupMotionManger() {
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        motionManager.accelerometerUpdateInterval = 0.005
        motionManager.startAccelerometerUpdates()
    }
    
    private func teardownMotionManager() {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
        motionManager.stopAccelerometerUpdates()
    }
    
    private func actualDeviceOrientationFromAccelerometer() -> UIDeviceOrientation? {
        guard let acceleration = motionManager.accelerometerData?.acceleration else { return nil }
        
        if acceleration.z < -0.75 {
            return UIDeviceOrientation.faceUp
        }
        
        if acceleration.z > 0.75 {
            return UIDeviceOrientation.faceDown
        }
        
        let scaling = 1.0 / (fabs(acceleration.x) + fabs(acceleration.y))
        
        let x = acceleration.x * scaling
        let y = acceleration.y * scaling
        
        if x < -0.5 {
            return UIDeviceOrientation.landscapeLeft
        }
        
        if x > 0.5 {
            return UIDeviceOrientation.landscapeRight
        }
        
        if y > 0.5 {
            return UIDeviceOrientation.portraitUpsideDown
        }
        
        return UIDeviceOrientation.portrait
    }
    
    deinit {
        teardownMotionManager()
    }
}
