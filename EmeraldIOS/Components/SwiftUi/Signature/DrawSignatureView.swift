//
//  drawSignatureView.swift
//  EmeraldIOS
//
//  Created by David Polania on 30/08/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import SwiftUI
import PencilKit
import UIKit

struct Line {
    var points = [CGPoint]()
    var color: Color = .black
    var lineWidth: Double = 2.0
}

struct DrawSignatureView: View {
    @Binding var imageDraw: UIImage
    @Binding var showBoard: Bool
    
    private let iconClosed = "xmark"
    private let textButtonClear = "Clear signature"
    private let textButtonDone = "Done signing"
    private let widthImage = UIScreen.main.bounds.width
    
    @State private var currentLine: Line = Line()
    @State private var lines: [Line] = []
    @State private var thickness: Double = 2.0
    @State private var presentedNotSign: Bool = false
    @State private var closedNotSign: Bool = false
    @State private var canvasView = PKCanvasView()
    
    @Environment(\.undoManager) private var undoManager
        
 
    var body: some View {
        VStack(alignment: .leading) {
            closeButton
            drawingControl
            Spacer()
            buttonsViews
        }
        .background(Color.gray.opacity(0.1))
    }
    
    @ViewBuilder
    var closeButton : some View {
        Button {
            if self.lines.count == 0 {
                showBoard.toggle()
            } else {
                closedNotSign = true
            }
        } label: {
            Image(systemName: iconClosed)
                .font(.system(size: 20))
                .foregroundColor(.blue)
                .padding()
        }
    }
    
    @ViewBuilder
    var buttonsViews: some View {
        if #available(iOS 15.0, *) {
            HStack {
                Button {
                    self.lines.removeAll()
                    self.imageDraw = UIImage()
                } label: {
                    Text(textButtonClear)
                        .fontWeight(.bold)
                        .padding(3)
                        .frame(maxWidth: .infinity)
                }
                .frame(height: 60)
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(5)
                
                
                Button {
                    if self.lines.count == 0 {
                        presentedNotSign = true
                    } else {
                        self.imageDraw = board.frame(width: widthImage,height: 250).snapshot()
                        self.showBoard.toggle()
                    }
                } label: {
                    Text(textButtonDone)
                        .fontWeight(.bold)
                        .padding(3)
                        .frame(maxWidth: .infinity)
                }
                .frame(height: 60)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(5)
            }
            .alert(Text("Please draw your signature"), isPresented: $presentedNotSign, actions: {}, message: {
                Text("you did not sign.")
            })
            .alert(isPresented:$closedNotSign) {
                        Alert(
                            title: Text(""),
                            message: Text("Are you sure you want to cancel?"),
                            primaryButton: .default(Text("Yes"), action: {
                                self.showBoard.toggle()
                            }),
                            secondaryButton: .cancel(Text("No"))
                        )
                    }
            .frame(maxWidth: .infinity)
            .padding(.bottom,20)
            .padding(.horizontal,20)
        } else {
            HStack {
                Button {
                    self.canvasView.drawing = PKDrawing()
                    self.imageDraw = UIImage()
                } label: {
                    Text(textButtonClear)
                        .fontWeight(.bold)
                        .padding(3)
                        .frame(maxWidth: .infinity)
                }
                .frame(height: 60)
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(5)
                
                
                Button {
                    self.imageDraw = canvasView.drawing.image(from: canvasView.drawing.bounds, scale: 1.0)
                    if  self.imageDraw == UIImage() {
                        presentedNotSign = true
                        return
                    } else {
                        self.showBoard = false
                    }
                } label: {
                    Text(textButtonDone)
                        .fontWeight(.bold)
                        .padding(3)
                        .frame(maxWidth: .infinity)
                }
                .frame(height: 60)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(5)
            }
            .alert(isPresented: $presentedNotSign, content: {
                Alert(
                    title: Text("Please draw your signature"),
                    message: Text("you did not sign.")
                )
            })
            .frame(maxWidth: .infinity)
            .padding(.bottom,20)
            .padding(.horizontal,20)
        }
    }
    @ViewBuilder
    var board: some View {
        if #available(iOS 15.0, *) {
            Canvas { context, size in
                for line in lines {
                    var path = Path()
                    path.addLines(line.points)
                    context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                }
            }
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged({ value in
                    let newPoint = value.location
                    currentLine.points.append(newPoint)
                    self.lines.append(currentLine)
                })
                    .onEnded({ value in
                        self.lines.append(currentLine)
                        self.currentLine = Line(points: [], color: currentLine.color, lineWidth: thickness)
                    })
            )
        }
    }
    
    @ViewBuilder
    var drawingControl: some View {
        VStack(alignment: .center) {
            ZStack {
                if #available(iOS 15.0, *) {
                    VStack {
                        VStack {
                            HStack {
                                Image(systemName: "xmark")
                                    .frame(width: 30, height: 30)
                                Spacer()
                            }
                            
                            Rectangle().frame(height: 2)
                            Text("Sign Here")
                                .frame(maxWidth: .infinity)
                                
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity, maxHeight: 250,alignment: .bottom)
                    .background(Color.white)
                    
                    board
                        .background(Color.clear)
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, maxHeight: 250)
                } else {
                    VStack {
                        VStack {
                            HStack {
                                Image(systemName: "xmark")
                                    .frame(width: 30, height: 30)
                                Spacer()
                            }
                            
                            Rectangle().frame(height: 2)
                            Text("Firmar Aqui")
                                .frame(maxWidth: .infinity)
                                
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity, maxHeight: 250,alignment: .bottom)
                    .background(Color.white)
                    
                    MyCanvas(canvasView: $canvasView)
                    .background(Color.white)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, maxHeight: 250)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

    

struct MyCanvas: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView

    func makeUIView(context: Context) -> PKCanvasView {
        if #available(iOS 14.0, *) {
            canvasView.drawingPolicy = .anyInput
        }
        canvasView.tool = PKInkingTool(.marker, color: .black, width: 3)
        return canvasView
    }

    func updateUIView(_ canvasView: PKCanvasView, context: Context) { }
}
