//
//  EmeraldCollectionChip.swift
//  EmeraldIOS
//
//  Created by David Polania on 15/09/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import SwiftUI

public struct ChipsDataModel: Swift.Identifiable {
    public var id: String = UUID().uuidString
    @State var isSelected: Bool
    let systemImage: String
    let titleKey: String
    
    public init(isSelected: Bool, title: String) {
        self.isSelected = isSelected
        self.systemImage = "xmark.circle"
        self.titleKey = title
    }
}

public class ChipsViewLogic: ObservableObject {
    @Published var dataObject: [ChipsDataModel]
    
    public init() {
        self.dataObject = []
    }
    
    public func removeLast() {
        guard dataObject.count != 0 else {
            return
        }
        dataObject.removeLast()
    }
    
    public func removeWithIdetificator (id: String) {
        if let index = dataObject.firstIndex(where: {$0.id == id}) {
            dataObject.remove(at: index)
        }
    }
    
    public func removeAll() {
        dataObject.removeAll()
    }
    
    public func get() -> [ChipsDataModel] {
        dataObject
    }
    
    public func set(_ data: [ChipsDataModel]) {
        self.dataObject = data
    }
    
    public func add(_ data: ChipsDataModel) {
        self.dataObject.append(data)
    }
}

public struct EmeraldCollectionChip: View {
    @ObservedObject var Logic: ChipsViewLogic
    
    public init(_ logic: ChipsViewLogic) {
        self.Logic = logic
    }
    
    public var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return VStack {
            GeometryReader { geo in
                ScrollView {
                    ZStack(alignment: .topLeading, content: {
                    ForEach(Logic.dataObject) { chipsData in
                        Chips(id: chipsData.id,
                              systemImage: chipsData.systemImage,
                              titleKey: chipsData.titleKey, idChipSelected:{ identificate in
                            Logic.removeWithIdetificator(id: identificate)
                        },
                              isSelected: chipsData.isSelected)
                            .padding(.all, 5)
                            .alignmentGuide(.leading) { dimension in
                                if (abs(width - dimension.width) > geo.size.width) {
                                    width = 0
                                    height -= dimension.height
                                }
                                
                                let result = width
                                if chipsData.id == Logic.dataObject.last!.id {
                                    width = 0
                                } else {
                                    width -= dimension.width
                                }
                                return result
                              }
                            .alignmentGuide(.top) { dimension in
                                let result = height
                                if chipsData.id == Logic.dataObject.last!.id {
                                    height = 0
                                }
                                return result
                            }
                    }
                })
                }
            }
            .padding(.all, 10)
        }
        .background(Color.white)
        .cornerRadius(5)
    }
}


public struct Chips: View {
    let id: String
    let systemImage: String
    let titleKey: String
    var idChipSelected: ((String)->Void)
    @State var isSelected: Bool
    public var body: some View {
        HStack {
            Text(titleKey)
                .font(.body)
                .lineLimit(1)
            Button(){
                isSelected.toggle()
                idChipSelected(id)
            } label: {
                Image.init(systemName: systemImage).font(.caption)
                    .foregroundColor(EmeraldTheme.extraLightTextColor.suColor)
            }
        }.padding(.all, 10)
        .background(isSelected ? Color.blue : EmeraldTheme.pagerBackgroundColor.suColor)
        .cornerRadius(40)
        .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.clear, lineWidth: 1.5)
        
        )
    }
}

