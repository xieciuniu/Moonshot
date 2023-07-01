//
//  ExtractedView.swift
//  Moonshot
//
//  Created by Hubert Wojtowicz on 06/07/2023.
//

import SwiftUI

struct CrewMember2 {
    let role: String
    let astronaut: Astronaut
}

struct CrewView: View {
    let mission: Mission
    let crew: [CrewMember2]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    .padding(.bottom)
        
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember2(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

struct RectangleStruct: View {

    var body: some View {
        Rectangle()
            .frame(height:2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct ExtractedView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        CrewView(mission: missions[0], astronauts: astronauts)
        RectangleStruct()
    }
}
