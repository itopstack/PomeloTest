//
//  PomeloTestApp.swift
//  PomeloTest
//
//  Created by ERX-C02G47CEQ05N on 22/2/2565 BE.
//

import SwiftUI

@main
struct PomeloTestApp: App {
    var body: some Scene {
        WindowGroup {
            ArticleListContentView(viewModel: ArticleListContentView.ViewModel())
        }
    }
}
