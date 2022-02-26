//
//  ActivityViewController.swift
//  PomeloTest
//
//  Created by ERX-C02G47CEQ05N on 26/2/2565 BE.
//

import Foundation
import SwiftUI

struct ActivityViewController: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIActivityViewController
    
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
}
