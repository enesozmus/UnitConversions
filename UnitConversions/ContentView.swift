//
//  ContentView.swift
//  UnitConversions
//
//  Created by enesozmus on 1.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var _inputDoubleData: Double?
    
    @State private var _actualUnitOptions: UnitLength = .meters
    @State private var _targetUnitOptions: UnitLength = .feet
    
    @FocusState private var _inputNumIsFocused: Bool
    
    let units: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
    
    var _result: Double? {
        guard let _inputDoubleData = _inputDoubleData else { return nil }
        
        let inputMeasurement = Measurement(value: _inputDoubleData, unit: _actualUnitOptions)
        
        return inputMeasurement.converted(to: _targetUnitOptions).value
    }
    
    
    var body: some View {
        NavigationView{
            Form{
                
                
                Section{
                    Picker("Input units", selection: $_actualUnitOptions){
                        ForEach(units, id: \.self){
                            Text("\($0.symbol)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Input units")
                }
                
                
                Section{
                    Picker("Output units", selection: $_targetUnitOptions){
                        ForEach(units, id: \.self){
                            Text("\($0.symbol)")
                        }
                    }
                    .pickerStyle(.segmented)
                }header: {
                    Text("Output units")
                }
                
                
                Section{
                    TextField("Enter a number", value: $_inputDoubleData, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($_inputNumIsFocused)
                } header: {
                    Text("Input number")
                }
                
                
                Section{
                    Text(_result?.formatted() ?? "")
                }header: {
                    Text("Result")
                }
            }
            .navigationTitle("Unit Conversion")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    
                    Button("Done"){
                        _inputNumIsFocused = false
                    }
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
