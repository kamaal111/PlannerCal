//
//  DeviceModel.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 30/03/2021.
//

import SwiftUI

final class DeviceModel: ObservableObject {
    @Published var screenSize: CGSize

    init() {
        #if canImport(AppKit)
        if let mainScreenFrame = NSScreen.main?.frame {
            self.screenSize = CGSize(width: mainScreenFrame.width, height: mainScreenFrame.height)
        } else {
            self.screenSize = CGSize(width: 100, height: 100)
        }
        #elseif canImport(UIKit)
        let screenSize = UIScreen.main.fixedCoordinateSpace.bounds
        self.screenSize = CGSize(width: screenSize.width, height: screenSize.width)
        #endif
        
    }
}
