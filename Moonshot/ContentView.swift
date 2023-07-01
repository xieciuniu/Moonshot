//
//  ContentView.swift
//  Moonshot
//
//  Created by Hubert Wojtowicz on 01/07/2023.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    @State private var showing = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum:showing ? 150 : 300))]){
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            if showing {
                                VStack {
                                    Image(mission.image)
                                        .resizable()
                                        .padding()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                    
                                    VStack {
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(mission.formattedLaunchDate)
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.5))
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(.lightBackground)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightBackground)
                                )
                            } else {
                                HStack {
                                    Image(mission.image)
                                        .resizable()
                                        .padding()
                                        .scaledToFit()
                                        .frame(width: 100, height: 80)
                                    
                                    VStack {
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(mission.formattedLaunchDate)
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.5))
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(.lightBackground)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightBackground)
                                )
                            }
                            
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            
            .toolbar{
                ToolbarItemGroup {
                    Button(showing ? "Show as List" : "Show as Grid") {
                        showing.toggle()
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
