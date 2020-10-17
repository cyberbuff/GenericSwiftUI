//
//  LoadingView.swift
//  GenericSwiftUI
//
//  Created by 0x6c on 10/11/20.
//  Copyright © 2020 0x6c. All rights reserved.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    
    @State var shouldAnimate = false
    
    var body: some View {
        Circle()
            .fill(Color.blue)
            .frame(width: 30, height: 30)
            .overlay(
                ZStack {
                    Circle()
                        .stroke(Color.blue, lineWidth: 100)
                        .scaleEffect(shouldAnimate ? 1 : 0)
                    Circle()
                        .stroke(Color.blue, lineWidth: 100)
                        .scaleEffect(shouldAnimate ? 1.5 : 0)
                    Circle()
                        .stroke(Color.blue, lineWidth: 100)
                        .scaleEffect(shouldAnimate ? 2 : 0)
                }
                .opacity(shouldAnimate ? 0.0 : 0.2)
                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false))
        )
        .onAppear {
            self.shouldAnimate = true
        }
    }
    
}
