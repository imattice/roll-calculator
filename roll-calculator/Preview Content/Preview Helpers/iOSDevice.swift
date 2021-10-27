//
//  iOSDevice.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/21/21.
//

import Foundation

/// Contains options for iOS devices
enum iOSDevice {
    case iPhone6Plus
    case iPhone6
    case iPhone6s
    case iPhone6sPlus
    case iPhoneSE1stGen
    case iPhone7
    case iPhone7Plus
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case iPhoneXs
    case iPhoneXsMax
    case iPhoneXʀ
    case iPhone11
    case iPhone11Pro
    case iPhone11ProMax
    case iPhoneSE2ndGen
    case iPhone12mini
    case iPhone12
    case iPhone12Pro
    case iPhone12ProMax
    case iPodTouch

    /// The device name
    var name: String {
        switch self {
        case .iPhone6:
            return "iPhone 6"
        case .iPhone6Plus:
            return "iPhone 6 Plus"
        case .iPhone6s:
            return "iPhone 6s"
        case .iPhone6sPlus:
            return "iPhone 6s Plus"
        case .iPhone7:
            return "iPhone 7"
        case .iPhone7Plus:
            return "iPhone 7 Plus"
        case .iPhone8:
            return "iPhone 8"
        case .iPhone8Plus:
            return "iPhone 8 Plus"
        case .iPhoneX:
            return "iPhone X"
        case .iPhoneXs:
            return "iPhone Xs"
        case .iPhoneXsMax:
            return "iPhone Xs Max"
        case .iPhoneXʀ:
            return "iPhone Xʀ"
        case .iPhone11:
            return "iPhone 11"
        case .iPhone11Pro:
            return "iPhone 11 Pro"
        case .iPhone11ProMax:
            return "iPhone 11 Pro Max"
        case .iPhoneSE1stGen:
            return "iPhone SE (1st generation)"
        case .iPhoneSE2ndGen:
            return "iPhone SE (2nd generation)"
        case .iPhone12mini:
            return "iPhone 12 mini"
        case .iPhone12:
            return "iPhone 12"
        case .iPhone12Pro:
            return "iPhone 12 Pro"
        case .iPhone12ProMax:
            return "iPhone 12 Pro Max"
        case .iPodTouch:
            return "iPod touch (7th generation)"
        }
    }
}
