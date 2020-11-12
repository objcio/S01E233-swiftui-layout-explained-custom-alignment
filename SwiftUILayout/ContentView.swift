//
//  ContentView.swift
//  NotSwiftUI
//
//  Created by Chris Eidhof on 05.10.20.
//

import SwiftUI
import Cocoa

func render<V: View_>(view: V, size: CGSize) -> Data {
    return CGContext.pdf(size: size) { context in
        view
            .frame(width: size.width, height: size.height)
            ._render(context: context, size: size)
    }
}

extension View_ {
    var measured: some View_ {
        overlay(GeometryReader_ { size in
            Text_("\(Int(size.width))")
        })
    }
}

struct ContentView: View {
    let size = CGSize(width: 600, height: 400)

    
    var sample: some View_ {
        Rectangle_()
            .foregroundColor(.gray)
            .frame(width: 100, height: 100)
            .alignmentGuide(for: .center) { size in
                size.width
            }
            .border(.red, width: 2)
            .frame(width: width.rounded(), height: 300, alignment:  .center)
        
    }
    


    @State var opacity: Double = 0.5
    @State var width: CGFloat  = 300

    var body: some View {
        VStack {
            ZStack {
                Image(nsImage: NSImage(data: render(view: sample, size: size))!)
                    .opacity(1-opacity)
                sample.swiftUI.frame(width: size.width, height: size.height)
                    .opacity(opacity)
            }
            Slider(value: $opacity, in: 0...1)
                .padding()
            HStack {
                Text("Width \(width.rounded())")
                Slider(value: $width, in: 0...600)
            }.padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 1080/2)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
