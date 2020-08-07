//
//  ContentView.swift
//  Calculator
//
//  Created by Vido Valianto on 7/11/20.
//  Copyright © 2020 Vido Valianto. All rights reserved.
//

import SwiftUI

struct CalculatorView: View {
    @ObservedObject var calculatorVM = CalculatorViewModel.shared

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                TextField("0", text: self.$calculatorVM.text
                )
                    .multilineTextAlignment(.trailing)
                    .font(Font.system(size: 80,
                                      weight: .bold,
                                      design: .rounded))
                    .frame(minHeight: geometry.size.height/4,
                           maxHeight: geometry.size.height/4)

                HStack(alignment: .top) {
                    VStack {
                        HStack {
                            ForEach(self.calculatorVM.toolButtons, id: \.self) { tool in
                                CircularButtonView(text: String(tool),
                                                   color: Color(CalculatorView.toolcolor))
                                    .onTapGesture {
                                        self.calculatorVM.toolButtonClicked(tool)
                                }
                            }
                        }

                        Grid(items: self.calculatorVM.numberButtons, id: \.self) { number in
                            CircularButtonView(text: number,
                                               color: Color(CalculatorView.numbercolor))
                                .onTapGesture {
                                    self.calculatorVM.numberButtonClicked(number)
                            }
                        }
                        Spacer()
                    }

                    VStack {
                        ForEach(self.calculatorVM.operationButtons, id: \.self) { operation in
                            CircularButtonView(text: String(operation),
                                               color: Color(CalculatorView.operationcolor))
                                .onTapGesture {
                                    self.calculatorVM.operationButtonClicked(operation)
                            }
                        }
                    }
                }
                .frame(minHeight: geometry.size.height/2, maxHeight: geometry.size.height*3/4)
                Spacer()
            }.padding()
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}

extension CalculatorView {
    static let numbercolor = UIColor(hex: "#333333")
    static let operationcolor = UIColor(hex: "#f39938")
    static let toolcolor = UIColor(hex: "#a6a6a6")
}
