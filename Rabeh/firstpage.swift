//
//  firstpage.swift
//  Rabeh
//
//  Created by Felwah on 02/04/1445 AH.
//

import SwiftUI

struct firstpage: View {
    @State var isActive: Bool = false
    var body: some View {
            
            
            ZStack {
                
                if self.isActive {
                    // MainView()
                    VideoPlayerView()
                    
                    
                } else {
                  
                    Image("popup")
                        .scaledToFill()
                        .frame(width: 1200, height: 830) .edgesIgnoringSafeArea(.all)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        self.isActive = true
                    }
                }
                
                
            }
            
        }
    }


struct firstpage_Previews: PreviewProvider {
    static var previews: some View {
        firstpage()
    }
}
