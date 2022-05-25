//
//  ContentView.swift
//  WeatherHello
//
//  Created by Anita Stashevskaya on 25.05.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .white],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Omsk")
                    .font(.system(size: 30, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding(5)
                VStack(spacing: 8) {
                    Image(systemName: "cloud.sun.rain.fill")//поправить фон
                        .renderingMode(.original)//make icon colorful
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 100)
                    
                    Text("27")
                        .font(.system(size: 40, weight: .light, design: .default))
                        .foregroundColor(.white)//degrees
                }
                HStack {
                    ExtractedView()
                }
                Spacer() //move text upp
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}

struct ExtractedView: View {
    var body: some View {
        VStack {
            Text("MON")
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: "cloud.sun.rain.fill")//поправить фон
                .renderingMode(.original)//make icon colorful
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("27")
                .font(.system(size: 28, weight: .light, design: .default))
                .foregroundColor(.white)//degrees
        }
    }
}
