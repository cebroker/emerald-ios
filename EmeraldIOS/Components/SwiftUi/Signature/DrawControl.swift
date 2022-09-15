//
//  DrawControl.swift
//  EmeraldIOS
//
//  Created by David Polania on 30/08/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import SwiftUI

public struct DrawControl: View {
    @Binding var image: UIImage
    @State private var showBoard: Bool = false
    @Binding var labelButton: String
    
    public init(image: Binding<UIImage>, labelButton: Binding<String>){
        _image = image
        _labelButton = labelButton
    }
    
    public var body: some View {
        if image == UIImage() {
            buttonControlDraw
        } else {
            chageDraw
        }
    }
    
    @ViewBuilder
    var chageDraw: some View {
        VStack {
            Image(uiImage: self.image)
                .resizable()
                .frame(width:200,height: 100)
                .scaledToFill()
            Button {
                self.showBoard.toggle()
            } label: {
                Text("Changue")
            }.sheet(isPresented: $showBoard) {
                DrawSignatureView(imageDraw: $image, showBoard: $showBoard)
            }
        }
    }
    
    @ViewBuilder
    var buttonControlDraw: some View {
        Button {
            self.showBoard.toggle()
        } label: {
            Text(labelButton)
                .fontWeight(.bold)
                .padding(3)
                .frame(maxWidth: .infinity)
        }
        .frame(height: 60)
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(5)
        .sheet(isPresented: $showBoard) {
            DrawSignatureView(imageDraw: $image, showBoard: $showBoard)
        }
    }
}

//struct DrawControl_Previews: PreviewProvider {
//    static var previews: some View {
//        DrawControl(image: UIImage())
//    }
//}

struct CounterView: View {
    
    @Binding var imageDraw: UIImage
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Incrementar") {
                imageDraw = UIImage()
            }
        }
    }
}
