//
//  TagView.swift
//  HW2
//
//  Created by Nathan Kim on 1/30/22.
//

import UIKit
import SwiftUI
import Foundation

struct TagView: View {
    @State var label: String
    
    var body: some View {
        ZStack {
            Text(label).background(RoundedRectangle(cornerRadius: 24).foregroundColor(Color.gray).padding(-4))
            
        }
    }
}
