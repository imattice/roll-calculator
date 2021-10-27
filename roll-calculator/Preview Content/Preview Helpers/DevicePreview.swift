//
//  DevicePreview.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/21/21.
//

import SwiftUI

/// Displays content for the given devices
struct DevicePreview<Content: View>: View {
    /// The views to display
    let content: () -> Content
    /// The devices to display
    let devices: [iOSDevice]

    var body: some View {
        ForEach(devices, id:\.self) { device in
            content()
                .previewDevice(PreviewDevice(rawValue: device.name))
                .previewDisplayName("\(device.name)")
        }
    }

    init(devices: [iOSDevice] = [],
         @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        if devices.isEmpty {
            self.devices = [
                .iPodTouch,
                .iPhoneSE1stGen,
                .iPhone6,
                .iPhone8,
                .iPhone8Plus,
                .iPhoneX,
                .iPhoneXs,
                .iPhone12ProMax
            ]
        } else {
            self.devices = devices
        }
    }
}

// MARK: - Previews
struct DevicePreview_Previews: PreviewProvider {
    static var previews: some View {
        DevicePreview {
            Text("Preview text")
        }
    }
}
