//
//  EmptyDataView.swift
//  GenericSwiftUI
//
//  Created by 0x6c on 10/17/20.
//  Copyright © 2020 0x6c. All rights reserved.
//

import Foundation
import SwiftUI

struct EmptyDataView: View {
    
    var text : String
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                Image("ng-black")
                    .resizable()
                    .frame(width: geometry.size.width/3, height: geometry.size.width/3, alignment: .center)
                Text(text).multilineTextAlignment(.center)
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
    }
    
}
