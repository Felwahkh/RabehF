//
//  seconed.swift
//  Rabeh
//
//  Created by Felwah on 29/03/1445 AH.
//

import SwiftUI

struct seconed: View {
    var body: some View {
        ZStack {
            Image("background222")
                .resizable()
                .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            Image("kafoRabeh")
                .position(x: 150, y: 500)
            
        }   .navigationBarBackButtonHidden(true).transition(.offset(x: 0, y: 0))
    }
}

struct seconed_Previews: PreviewProvider {
    static var previews: some View {
        seconed()
    }
}
