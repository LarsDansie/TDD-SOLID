//
//  ContentView.swift
//  TDD3
//
//  Created by Lars Dansie on 1/30/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        
        //Liskov Substitution
        .onAppear {
            startGame(game: ArcadeGame(title: "Fake Game"))
        }
        .padding()
    }
    
    func startGame(game: Game) {
        game.startGame()
    }
}

//interface segregation for playing game and dispensing tickets
protocol PlayableGame {
    func startGame()
}

extension PlayableGame {
    func startGame() {
        print("Game Started!")
    }
}

class ClawMachine: Game {
}

class ArcadeGame: Game {
}

class Game: PlayableGame {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}

let squeekyMcSqueek = ClawMachine(title: "Squeeky Mc Squeeks Fantastic Claw Machine")
//squeekyMcSqueek.startGameMessage()

let pacMan = ArcadeGame(title: "Don't sue me whoever owns pacman")
//pacMan.startGameMessage()



protocol DispensesTickets {
    func giveTickets(_ tickets: Int) -> String
}

//single responsibility
class PrintTickets: DispensesTickets {
    func giveTickets(_ tickets: Int) -> String {
        return "Printing \(tickets) tickets!"
    }
}

class SaveToCard: DispensesTickets {
    func giveTickets(_ tickets: Int) -> String {
        return "Saving \(tickets) tickets to card!"
    }
}

//Open/Closed Adding func by extending system

class SaveOnline: DispensesTickets {
    func giveTickets(_ tickets: Int) -> String {
        //sends tickets to registered online account
        return "Saving tickets online"
    }
}

class TicketDispenser {
    private let dispenseTickets: DispensesTickets
    
    //dependency inversion / using interface instead of concrete instance
    init(dispenseTickets: DispensesTickets) {
        self.dispenseTickets = dispenseTickets
    }
    
    func end(_ tickets: Int) -> String {
        return dispenseTickets.giveTickets(tickets)
    }
}


//dependency injection
let ticketDispenserSolidTickets = TicketDispenser(dispenseTickets: PrintTickets())
let ticketDispenserEndCard = TicketDispenser(dispenseTickets: SaveToCard())
let ticketDispenserOnline = TicketDispenser(dispenseTickets: SaveOnline())

