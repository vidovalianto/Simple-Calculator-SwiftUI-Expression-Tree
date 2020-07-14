//
//  ButtonView.swift
//  Calculator
//
//  Created by Vido Valianto on 7/11/20.
//  Copyright © 2020 Vido Valianto. All rights reserved.
//

import SwiftUI

struct CircularButtonView: View {
    var text: String
    var color: Color = Color.gray

    var body: some View {
        ZStack {
            Circle()
                .fill(color)
            Text(text)
                .font(Font.system(size: 24,
                                  weight: .bold,
                                  design: .rounded))
                .foregroundColor(Color.white)
        }.frame(minWidth: 80, maxWidth: 80, minHeight: 80, maxHeight: 80)
    }
}

struct CircularButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CircularButtonView(text: "8")
    }
}
