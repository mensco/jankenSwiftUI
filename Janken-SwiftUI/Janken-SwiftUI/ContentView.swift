//
//  ContentView.swift
//  Janken-SwiftUI
//
//  Created by Katsuya Terahata on 2020/01/08.
//  Copyright © 2020 Katsuya Terahata. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var main_image = Image("janken")
    @State var enemyAction = "enemy"
    @State var resultLabel = "Rock, Paper, Scissors!"
    @State var winCountLabel = "Win: 0"
    @State var loseCountLabel = "Lose: 0"
    @State var winCount: Int = 0
    @State var loseCount: Int = 0
    
    // defnition of enemy action list
    var enemyActionList: [String] = ["rock","scissors","paper"]
    
    func displayEnemyImage(enemyAction:String){
        switch enemyAction{
        case "rock":
            main_image = Image("janken_gu")
        case "scissors":
            main_image = Image("janken_choki")
        case "paper":
            main_image = Image("janken_pa")
        default:
            print("error: enemyAction is inappropriate value")
        }
    }
    
    func displayWinCount(){
        winCount += 1
        winCountLabel = "Win:" + String(winCount) // int to string
    }
    func displayLoseCount(){
        loseCount += 1
        loseCountLabel = "Lose:" + String(loseCount) // int to string
    }
    
    func randomEnemyAction() -> String {
        enemyAction = enemyActionList.randomElement()! // list must not be empty so unwrap forcibly
        displayEnemyImage(enemyAction: enemyAction)
        return enemyAction
    }
    
    func judgement(enemyAction: String, myAction: String){
        switch enemyAction {
        case "rock":
            switch myAction {
            case "rock":
                self.resultLabel = "Draw"
            case "scissors":
                displayLoseCount()
                self.resultLabel = "You Lose!"
            case "paper":
                displayWinCount()
                self.resultLabel = "You Win!"
            default:
                self.resultLabel = "error: myAction is inappropriate value"
            }
        case "scissors":
            switch myAction {
            case "rock":
                displayWinCount()
                self.resultLabel = "You Win!"
            case "scissors":
                self.resultLabel = "Draw"
            case "paper":
                displayLoseCount()
                self.resultLabel = "You Lose!"
            default:
                self.resultLabel = "error: myAction is inappropriate value"
                }
        case "paper":
            switch myAction{
            case "rock":
                displayLoseCount()
                self.resultLabel = "You Lose!"
            case "scissors":
                displayWinCount()
                self.resultLabel = "You Win!"
            case "paper":
                self.resultLabel = "Draw"
            default:
                self.resultLabel = "error: myAction is inappropriate value"
            }
        default:
            self.resultLabel = "error: enemyACtion is inappropriate value"
        }
    }
    
    var body: some View {
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)
            GeometryReader{ geometry in
                VStack(alignment: .center){
                    Spacer()
                    Text("Let's play!")
                        .font(.title)
                        .foregroundColor(Color.red)
                        .padding(.bottom)
                        .offset(y: -geometry.size.height / 10)
                    self.main_image
                        .resizable()
                        .frame(width: geometry.size.width / 2,
                                height: geometry.size.height / 3)
                        .offset(y: -geometry.size.height / 25)
                        if self.enemyAction == "enemy"{
                            Text(self.enemyAction)
                                .padding()
                                .offset(y: -geometry.size.height / 20)
                                .hidden()
                                
                        }
                        else{
                            Text(self.enemyAction)
                                .padding()
                                .offset(y: -geometry.size.height / 20)
                        }
                    Text(self.resultLabel)
                        .font(.title)
                        .foregroundColor(Color.red)
                        .padding(.bottom)
                        .offset(y: -geometry.size.height / 20)
                    
                    HStack {
                        Text(String(self.winCountLabel))
                            .padding(.trailing)
                            .offset(y: -geometry.size.height / 30)
                        Text(String(self.loseCountLabel))
                            .padding(.leading)
                            .offset(y: -geometry.size.height / 30)
                    }
                    
                    HStack{
                        Button(
                            action: {self.judgement(enemyAction: self.randomEnemyAction(), myAction: "rock")},
                            label: {
                                Image("janken_gu")
                                    .resizable()
                                    .frame(width: geometry.size.width / 4,
                                           height: geometry.size.height / 6)
                            }
                        ).buttonStyle(PlainButtonStyle())
                        Button(
                            action: {self.judgement(enemyAction: self.randomEnemyAction(), myAction: "scissors")},
                            label: {
                                Image("janken_choki")
                                .resizable()
                                .frame(width: geometry.size.width / 4,
                                       height: geometry.size.height / 6)
                            }
                        ).buttonStyle(PlainButtonStyle())
                        Button(
                            action: {self.judgement(enemyAction: self.randomEnemyAction(), myAction: "paper")},
                            label: {
                                Image("janken_pa")
                                .resizable()
                                .frame(width: geometry.size.width / 4,
                                       height: geometry.size.height / 6)
                            }
                        ).buttonStyle(PlainButtonStyle())
                    }
                    .padding(.bottom)
                    .offset(y: -geometry.size.height / 70)
                
                    
                
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
