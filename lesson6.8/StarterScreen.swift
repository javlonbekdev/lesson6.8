//
//  StarterScreen.swift
//  lesson8.8
//
//  Created by Javlonbek on 05/02/22.
//

import SwiftUI

struct StarterScreen: View {
    @EnvironmentObject var session: SessionStore
    var body: some View {
        VStack {
            if self.session.session != nil {
                HomeScreen()
            } else {
                SignInView()
            }
        }.onAppear {
            session.listen()
        }
    }
}

struct StarterScreen_Previews: PreviewProvider {
    static var previews: some View {
        StarterScreen()
    }
}
