//
//  Home.swift
//  SwiftUIDesignChallange (iOS)
//
//  Created by Toshiharu Imaeda on 2022/03/21.
//

import SwiftUI

struct Home: View {
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(spacing: 0) {
        HeaderView()
      }
    }
    .coordinateSpace(name: "SCROLL")
    .ignoresSafeArea(.container, edges: .vertical)
  }
  
  // MARK: - Header View
  @ViewBuilder
  func HeaderView() -> some View {
    GeometryReader { proxy in
      let minY = proxy.frame(in: .named("SCROLL")).minY
      let size = proxy.size
      let height = (size.height + minY)
      
      Image("mic")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: size.width, height: height, alignment: .top)
        .overlay(content: {
          ZStack(alignment: .bottom) {
            LinearGradient(colors: [
              .clear,
              .black.opacity(0.5)
            ], startPoint: .top, endPoint: .bottom)
            
            VStack(alignment: .leading, spacing: 8) {
              Text("Microphone")
                .font(.callout)
                .foregroundColor(.gray)
              
              HStack(alignment: .bottom) {
                Text("Blue Yeti")
                  .font(.title.bold())
                  .foregroundColor(.white)
              }
            }
            .padding(.horizontal)
            .padding(.bottom, 25)
            .frame(maxWidth: .infinity, alignment: .leading)
            
          }
        })
        .cornerRadius(15)
        .offset(y: -minY)
    }
    .frame(height: 250)
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
