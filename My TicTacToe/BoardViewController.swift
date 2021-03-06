//
//  ViewController.swift
//  My TicTacToe
//
//  Created by Jay on 10/24/16.
//  Copyright © 2016 Juan Pablo. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, BoardViewDelegate, GameOverDelegate {
    
    @IBOutlet weak var turnLabel: UILabel!
    
    let board = Board()
    var boardView: BoardView? = nil
    var gameOver: GameOverView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Remove this:
//        setUpView()
        setUpBoard()
        gameOverView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Setup View:
    //Remove this:
    func setUpView() {
        let background = UIImageView(frame: view.frame)
        background.image = #imageLiteral(resourceName: "blackBoardBackground")
        view.addSubview(background)
    }
    
    //Setup the Board View:
    func setUpBoard() {
        let width = view.bounds.width - 10
        let frame = CGRect(x: 0, y: 0, width: width, height: width)
        self.boardView = BoardView(frame: frame)
        self.boardView?.center = view.center
        view.addSubview(self.boardView!)
        self.boardView?.delegate = self
    }
    
    //Setup the GameOver View:
    func gameOverView() {
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        self.gameOver = GameOverView(frame: frame)
        gameOver?.delegate = self
        gameOver?.isHidden = true
        view.addSubview(self.gameOver!)
    }
    
    func didTapMenu(didTap: Bool) {
        if didTap {
            self.present(MenuViewController(), animated: true, completion: nil)
            gameOver?.isHidden = true
        }
    }
    
    //User tapped an area on the Board View:
    func tappedPosition(x: Int, y: Int) {
        let state = board.didTap(xPosition: x, yPosition: y)
        
        switch state {
        case .lost:
            turnLabel.text = board.turn == .circle ? "❌" : "⭕"
            let turn = board.turn == .circle ? "⭕" : "❌"
            boardView?.updateFieldAtPosition(xPosition: x, yPostion: y, turn: turn)
        case .win:
            gameOver?.isHidden = false
            boardView?.clear()
            board.clear()
            print("\(turnLabel.text!) Won!")
        case .full:
            gameOver?.isHidden = false
            boardView?.clear()
            board.clear()
            print("Full")
        case .taken:
            print("Taken")
        }
    }
}

