import SwiftUI
import AVKit
import AVFoundation


//class PlayerManager : ObservableObject {
//    let player = AVPlayer(url: Bundle.main.url(forResource: "rabehh4", withExtension: "mp4")!) // 2
//    @Published private var playing = false
//
//    func play() {
//        player.play()
//        playing = true
//    }
//
//    func playPause() {
//        if playing {
//            player.pause()
//        } else {
//            player.play()
//        }
//        playing.toggle()
//    }
//}


struct VideoPlayerView: View {
    
  //  @StateObject var playerManager = PlayerManager()

  //  @State private var player = AVPlayer()
    @State private var shouldNavigate = false
    
   // @State var player2 = AVPlayer(url: Bundle.main.url(forResource: "rabehh4", withExtension: "mp4")!) // 2
    
    

 
    
   // let var player3 = VideoPlayerController()

    var body: some View {
        if shouldNavigate {
            ContentView()
            
//            NavigationLink(destination: ContentView(), isActive: $shouldNavigate) {
//                //EmptyView()
//            }
        } else {
            NavigationView {
                ZStack {
                    
                    
                  //  AVPlayerControllerRepresented(player: playerManager.player)

                    
                    
//
//                    VideoPlayer(player: player2) // 3
//                        .edgesIgnoringSafeArea(.all)
//                        .frame(maxHeight: .infinity)

                    
                    
                    
                    VideoPlayerController(videoURL: Bundle.main.url(forResource: "rabehh4", withExtension: "mp4"), onVideoEnd: {
                        self.shouldNavigate = false
                    })
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxHeight: .infinity)
                    NavigationLink(
                                       destination: ContentView(),
                                       label: {
                                           Text("تخطي")
                                               .padding()
                                               .background( Color(red: 0.429, green: 0.199, blue: 0.127))
                                               .font(.system(size: 26))
                                                   .foregroundColor(Color.white)
                                               .foregroundColor(.white).clipShape(Capsule())
                                               
                                              
                                       }
                                   )  .isDetailLink(false).position(x:330 ,y:720)

                    NavigationLink(
                        destination: ContentView(),
                        isActive: $shouldNavigate,
                        label: {
//                            EmptyView()
                        }
                    )
                }
            }.onAppear{
               // player2.play()
                
              //  playerManager.play()

                
            }
            .onDisappear{
              //  playerManager.playPause()

                
               // player2 = nil

           
             // player2.pause()
             //   player2.seek(to: .zero)
                
              //  player2.rate = 0
                
             //   print("onDisappear")

             //   player2 = AVPlayer()
                


            }
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView()
    }
}

struct VideoPlayerController: UIViewControllerRepresentable {
    let videoURL: URL?
    let onVideoEnd: () -> Void

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspectFill

        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        if let videoURL = videoURL {
            let player = AVPlayer(url: videoURL)
            uiViewController.player = player
            uiViewController.player?.play()

            // Observe when the video ends
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                self.onVideoEnd()
                
                uiViewController.player?.pause()
                
                uiViewController.player?.seek(to: .zero)

            }
        }
    }
}



struct AVPlayerControllerRepresented : UIViewControllerRepresentable {
    var player : AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}
