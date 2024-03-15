//
//  ProgressBar.swift
//  quizeapp
//
//  Created by Chandrakant  Kondke on 15/03/24.
//

import SwiftUI

struct ProgressBar: View {
    var progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.3))
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: min(max(0, self.progress) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .animation(.easeInOut)
            }
        }
    }
}

#Preview {
    ProgressBar(progress: 0.5)
}
