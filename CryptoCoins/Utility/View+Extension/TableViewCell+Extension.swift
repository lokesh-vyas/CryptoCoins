//
//  TableViewCell+Extension.swift
//  CryptoCoins
//
//  Created by Lokesh Vyas on 22/10/24.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        let file = NSStringFromClass(Self.self)
        return file.components(separatedBy: ".").first!
    }
}
