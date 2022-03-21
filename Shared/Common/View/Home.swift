//
//  Home.swift
//  SwiftUIDesignChallange (iOS)
//
//  Created by Toshiharu Imaeda on 2022/03/21.
//

import SwiftUI

struct Home: View {
  @State var currentType: String = "Microphone"
  @State var devices: [Device] = Home.keyboards
  
  static let cameras: [Device] = [
    // TODO
  ]
  static let microphones: [Device] = [
    // TODO
  ]
  static let keyboards: [Device] = [
    Device(id: "1", name: "keyboard"),
    Device(id: "2", name: "keyboard"),
    Device(id: "3", name: "keyboard"),
    Device(id: "4", name: "keyboard"),
    Device(id: "5", name: "keyboard"),
    Device(id: "6", name: "keyboard"),
    Device(id: "7", name: "keyboard"),
    Device(id: "8", name: "keyboard"),
    Device(id: "9", name: "keyboard"),
    Device(id: "10", name: "keyboard"),
    Device(id: "11", name: "keyboard"),
    Device(id: "12", name: "keyboard"),
    Device(id: "13", name: "keyboard"),
    Device(id: "14", name: "keyboard"),
  ]
  
  // MARK: For Smooth Effect
  @Namespace var animation
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(spacing: 0) {
        HeaderView()
        
        // MARK: Pinned Header with Content
        LazyVStack(pinnedViews: [.sectionHeaders]) {
          Section {
            DeviceList()
              .padding(.horizontal)
              .padding(.vertical, 16)
          } header: {
            PinnedHeaderView()
          }

        }
      }
    }
    .coordinateSpace(name: "SCROLL")
    .ignoresSafeArea(.container, edges: .vertical)
  }
  
  // MARK: Header View
  @ViewBuilder
  func HeaderView() -> some View {
    GeometryReader { proxy in
      let minY = proxy.frame(in: .named("SCROLL")).minY
      let size = proxy.size
      let height = size.height + minY
      
      Image("mic")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: size.width, height: height < 0 ? 0 : height, alignment: .top)
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
  
  // MARK: Pinned Header
  @ViewBuilder
  func PinnedHeaderView() -> some View {
    let types: [String] = [
      "Microphone",
      "Camera",
      "Keyboard",
    ]
    
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 25) {
        ForEach(types, id: \.self) { type in
          VStack(spacing: 15) {
            Text(type)
              .fontWeight(.semibold)
              .foregroundColor(currentType == type ? .black : .gray)
            
            ZStack {
              if currentType == type {
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                  .fill(.black)
                  .matchedGeometryEffect(id: "TAB", in: animation)
              } else {
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                  .fill(.clear)
              }
            }
            .padding(.horizontal, 8)
            .frame(height: 4)
          }
          .contentShape(Rectangle())
          .onTapGesture {
            withAnimation(.easeOut) {
              currentType = type
            }
          }
        }
      }
      .padding(.horizontal)
      .padding(.top, 44)
      .padding(.bottom, 5)
    }
    .background(Color.white)
  }
  
  // MARK: Pinned Content
  @ViewBuilder
  func DeviceList() -> some View {
    VStack(spacing: 25) {
      ForEach($devices) { $device in
        HStack(spacing: 12) {
          Image(device.name)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 55, height: 55)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                       
          VStack(alignment: .leading, spacing: 8) {
            Text(device.name)
              .fontWeight(.semibold)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
    }
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
