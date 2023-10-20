//
//  ContentView.swift
//  Rabeh
//
//  Created by Felwah on 29/03/1445 AH.
//

import SwiftUI
import AVFoundation

var audioPlayer: AVAudioPlayer?

struct ContentView: View {
    @State private var progress = 0.0
    @State private var isProgressActive = false
    @State private var timer: Timer?
    @State private var buttonTitle = "افزع"
    @State private var currentImage: String = "rabeh-mad"
    @State private var shouldNavigate = false
    @State private var rotationAngle: Angle = .degrees(0.003)
    @State private var isBigSmallVisible = false
    @State private var backgroundIndex = 0
  
    
 

    var body: some View {
        NavigationView {
            ZStack {
                Image(backgroundIndex == 0 ? "background" : (backgroundIndex == 1 ? "midBackground" : "FINALBACKGROUND"))
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
       

                HStack(spacing: -18) {
                    let pic = progress <= 0.5 ? "fire" : "fire-green"
                    Image(pic)

                    ProgressView(value: progress, label: { Text("") }, currentValueLabel: { Text(progress.formatted(.percent.precision(.fractionLength(0)))) })
                        .progressViewStyle(ColoredRoundedRectProgressViewStyle(progress: progress))
                }.position(x: 200, y: 100)

                Group {
                    Image("Big")
                        .rotationEffect(rotationAngle)
                        .opacity(isBigSmallVisible ? 1 : 0)
                        .position(x: 100, y: 300)
                    
                    Image("Small")
                        .rotationEffect(rotationAngle)
                        .opacity(isBigSmallVisible ? 1 : 0)
                        .position(x: 130, y: 330)

                    Image("Small")
                        .rotationEffect(rotationAngle)
                        .opacity(isBigSmallVisible ? 1 : 0)
                        .position(x: 80, y: 340)
                }

                Image(currentImage)
                    .position(x: 150, y: 500)

                Button(action: {
                    if isProgressActive {
                        buttonTitle = "افزع"
                        currentImage = "rabeh-done"
                    } else {
                        buttonTitle = "خلصت"
                        currentImage = "RabehWorking"
                        audioPlayer?.play()
                    }
                    isProgressActive.toggle()
                    toggleProgress()
                    isBigSmallVisible.toggle()

                 
                }) {
                    ZStack {
                        Color(red: 0.429, green: 0.199, blue: 0.127)
                        Text(buttonTitle).font(.system(size: 36))
                            .foregroundColor(Color.white)
                    }
                    .clipShape(Capsule())
                }
                .frame(width: 190.0, height: 80.0)
                .padding(.top, 500.0)

                NavigationLink("", destination: seconed(), isActive: $shouldNavigate)
                    .opacity(0)
            }
            
        }.navigationBarBackButtonHidden(true)
        
        .onChange(of: progress) { newProgress in
            if newProgress > 0.5 && newProgress < 1.0 {
                backgroundIndex = 2
            }
        }
    }

        init() {
            if let path = Bundle.main.path(forResource: "SoundRabeh", ofType: "mp3") {
                let url = URL(fileURLWithPath: path)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer?.prepareToPlay()
                } catch {
                    print("Error loading audio: \(error)")
                }
            }
        }

        func toggleProgress() {
            if isProgressActive {
                startProgress()
            } else {
                stopProgress()
            }
        }

        func startProgress() {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.progress += 0.1
                if self.progress >= 1.0 {
                    stopProgress()
                    // Navigate to AnotherPage when progress is 100%
                    shouldNavigate = true
                }
            }
            
            // Rotate the "big" and "small" images
            withAnimation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false)) {
                rotationAngle = .degrees(360)
            }
        }

        // Function to stop the progress
        func stopProgress() {
            timer?.invalidate()
            timer = nil
            rotationAngle = .degrees(0) // Reset rotation angle
        }
    }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColoredRoundedRectProgressViewStyle: ProgressViewStyle {
    var progress: Double

    func makeBody(configuration: Configuration) -> some View {
        let color = progress <= 0.5 ? Color.red : Color.green
        return ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 14)
                .frame(width: 250, height: 28)
                .foregroundColor(.white)
                .cornerRadius(14)

            RoundedRectangle(cornerRadius: 14)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 250, height: 28)
                .foregroundColor(color)
        }
        .padding()
    }
}
