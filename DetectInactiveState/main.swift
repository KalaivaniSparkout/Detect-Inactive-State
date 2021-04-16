//
//  main.swift
//  Skal User
//
//  Created by Hxtreme on 2021-04-15.
//  Copyright © 2021 Appieatz Instant Food Delivery. All rights reserved.
//

import Foundation
import UIKit

CommandLine.unsafeArgv.withMemoryRebound(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))
{   argv in
    _ = UIApplicationMain(CommandLine.argc, argv, NSStringFromClass(CheckIdealState.self), NSStringFromClass(AppDelegate.self))
}
