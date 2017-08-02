#!/usr/bin/swift

import Foundation


var TOTAL_NODES = 0
var WINNNING_MOVES = Dictionary<Int, [[Int]]>()
var PLAYER = 0

//
//  Connect4
//
//  Created by Tanner Juby on 3/1/17.
//  Copyright © 2017 Juby. All rights reserved.
//

import Foundation

class GameState {
    
    // MARK: - Class Variables
    
    var key: Int!
    
    var player : Int
    var lastMove : Int?
    var bestMove : Int?
    
    var state : [[Int]] = []
    var width : Int!
    var height : Int!
    
    var value : Int = 0
    
    var childrenStates : [GameState] = []
    var childrenValues : [Int] = []
    
    weak var parentState : GameState?
    
    
    // MARK: - Class initializers
    
    init(key: Int, player: Int, state: [[Int]], width: Int, height: Int) {
        
        self.key = key
        
        self.player = player
        
        self.state = state
        self.width = width
        self.height = height
    }
    
    
    // MARK: - Class Functions
    
    /**
     Block Move
     
     Blocks a move if needed
     */
    func findWinOrBlock() -> Int {
        
        generateChildren()
        
        for i in 0 ..< WINNNING_MOVES.count {
            
            let move = WINNNING_MOVES[i]
            
            let index1 = move?[0]
            let index2 = move?[1]
            let index3 = move?[2]
            let index4 = move?[3]
            
            for child in childrenStates {
                
                // Determine Win Move
                if child.state[(index1?[0])!][(index1?[1])!] == 1 && child.state[(index2?[0])!][(index2?[1])!] == 1 && child.state[(index3?[0])!][(index3?[1])!] == 1 {
                    if index4?[1] != height-1 && child.parentState?.state[(index4?[0])!][((index4?[1])!)+1] != 0 && child.parentState?.state[(index4?[0])!][(index4?[1])!] != 1 {
                        return index4![0]
                    }
                    
                } else if child.state[(index1?[0])!][(index1?[1])!] == 1 && child.state[(index2?[0])!][(index2?[1])!] == 1 && child.state[(index4?[0])!][(index4?[1])!] == 1 {
                    if index3?[1] != height-1 && child.parentState?.state[(index3?[0])!][((index3?[1])!)+1] != 0 && child.parentState?.state[(index3?[0])!][(index3?[1])!] != 1 {
                        return index3![0]
                    }
                    
                } else if child.state[(index1?[0])!][(index1?[1])!] == 1 && child.state[(index3?[0])!][(index3?[1])!] == 1 && child.state[(index4?[0])!][(index4?[1])!] == 1 {
                    if index2?[1] != height-1 && child.parentState?.state[(index2?[0])!][((index2?[1])!)+1] != 0 && child.parentState?.state[(index2?[0])!][(index2?[1])!] != 1 {
                        return index2![0]
                    }
                    
                } else if child.state[(index2?[0])!][(index2?[1])!] == 1 && child.state[(index3?[0])!][(index3?[1])!] == 1 && child.state[(index4?[0])!][(index4?[1])!] == 1 {
                    if index1?[1] != height-1 && child.parentState?.state[(index1?[0])!][((index1?[1])!)+1] != 0 && child.parentState?.state[(index1?[0])!][(index1?[1])!] != 1 {
                        return index1![0]
                    }
                }
                
                if player == 1 {
                    // Determine Block Move for Player 1
                    if child.state[(index1?[0])!][(index1?[1])!] == 2 && child.state[(index2?[0])!][(index2?[1])!] == 2 && child.state[(index3?[0])!][(index3?[1])!] == 2 && child.state[(index4?[0])!][(index4?[1])!] == 1 {
                        
                        return index4![0]
                        
                    } else if child.state[(index1?[0])!][(index1?[1])!] == 2 && child.state[(index2?[0])!][(index2?[1])!] == 2 && child.state[(index3?[0])!][(index3?[1])!] == 1 && child.state[(index4?[0])!][(index4?[1])!] == 2 {
                        
                        return index3![0]
                        
                    } else if child.state[(index1?[0])!][(index1?[1])!] == 2 && child.state[(index2?[0])!][(index2?[1])!] == 1 && child.state[(index3?[0])!][(index3?[1])!] == 2 && child.state[(index4?[0])!][(index4?[1])!] == 2 {
                        
                        return index2![0]
                        
                    } else if child.state[(index1?[0])!][(index1?[1])!] == 1 && child.state[(index2?[0])!][(index2?[1])!] == 2 && child.state[(index3?[0])!][(index3?[1])!] == 2 && child.state[(index4?[0])!][(index4?[1])!] == 2 {
                        
                        return index1![0]
                    }
                    
                    
                } else {
                    
                    // Determine Win Move
                    if child.parentState?.state[(index1?[0])!][(index1?[1])!] == 2 && child.parentState?.state[(index2?[0])!][(index2?[1])!] == 2 && child.parentState?.state[(index3?[0])!][(index3?[1])!] == 2 {
                        if index4?[1] != height-1 && child.parentState?.state[(index4?[0])!][((index4?[1])!)+1] != 0 && child.parentState?.state[(index4?[0])!][(index4?[1])!] != 1 {
                            return index4![0]
                        }
                        
                    } else if child.parentState?.state[(index1?[0])!][(index1?[1])!] == 2 && child.parentState?.state[(index2?[0])!][(index2?[1])!] == 2 && child.parentState?.state[(index4?[0])!][(index4?[1])!] == 2 {
                        if index3?[1] != height-1 && child.parentState?.state[(index3?[0])!][((index3?[1])!)+1] != 0 && child.parentState?.state[(index3?[0])!][(index3?[1])!] != 1 {
                            return index3![0]
                        }
                        
                    } else if child.parentState?.state[(index1?[0])!][(index1?[1])!] == 2 && child.parentState?.state[(index3?[0])!][(index3?[1])!] == 2 && child.parentState?.state[(index4?[0])!][(index4?[1])!] == 2 {
                        if index2?[1] != height-1 && child.parentState?.state[(index2?[0])!][((index2?[1])!)+1] != 0 && child.parentState?.state[(index2?[0])!][(index2?[1])!] != 1 {
                            return index2![0]
                        }
                        
                    } else if child.parentState?.state[(index2?[0])!][(index2?[1])!] == 2 && child.parentState?.state[(index3?[0])!][(index3?[1])!] == 2 && child.parentState?.state[(index4?[0])!][(index4?[1])!] == 2  {
                        if index1?[1] != height-1 && child.parentState?.state[(index1?[0])!][((index1?[1])!)+1] != 0 && child.parentState?.state[(index1?[0])!][(index1?[1])!] != 1 {
                            return index1![0]
                        }
                    }
                
                    // Determine Block Move For Player 2
                    if child.state[(index1?[0])!][(index1?[1])!] == 1 && child.state[(index2?[0])!][(index2?[1])!] == 1 && child.state[(index3?[0])!][(index3?[1])!] == 1 && child.state[(index4?[0])!][(index4?[1])!] == 2 {
                        
                        return index4![0]
                        
                    } else if child.state[(index1?[0])!][(index1?[1])!] == 1 && child.state[(index2?[0])!][(index2?[1])!] == 1 && child.state[(index3?[0])!][(index3?[1])!] == 2 && child.state[(index4?[0])!][(index4?[1])!] == 1 {
                        
                        return index3![0]
                        
                    } else if child.state[(index1?[0])!][(index1?[1])!] == 1 && child.state[(index2?[0])!][(index2?[1])!] == 2 && child.state[(index3?[0])!][(index3?[1])!] == 1 && child.state[(index4?[0])!][(index4?[1])!] == 1 {
                        
                        return index2![0]
                        
                    } else if child.state[(index1?[0])!][(index1?[1])!] == 2 && child.state[(index2?[0])!][(index2?[1])!] == 1 && child.state[(index3?[0])!][(index3?[1])!] == 1 && child.state[(index4?[0])!][(index4?[1])!] == 1 {
                        
                        return index1![0]
                    }
                }
            }
        }
        
        return -1
    }
    
    /**
     Generate Possible Moves
     
     Generates possible moves for the current state
     */
    func generateChildren() {
        
        childrenStates = []
        
        for i in 0 ..< width {
            if state[i][0] == 0 {
                
                var madeMove = false
                
                for j in 1 ..< height {
                    if !madeMove {
                        if state[i][j] != 0 {
                            
                            var newState = state
                            var newGameState : GameState
                            
                            if player == 1 {
                                newState[i][j-1] = 1
                                newGameState = GameState(key: TOTAL_NODES+1, player: 2, state: newState, width: width, height: height)
                                newGameState.parentState = self
                                newGameState.lastMove = i
                            } else {
                                newState[i][j-1] = 2
                                newGameState = GameState(key: TOTAL_NODES+1, player: 1, state: newState, width: width, height: height)
                                newGameState.parentState = self
                                newGameState.lastMove = i
                            }
                            madeMove = true
                            childrenStates.append(newGameState)
                            
                        } else if j == height-1 {
                            
                            var newState = state
                            var newGameState : GameState
                            
                            if player == 1 {
                                newState[i][j] = 1
                                newGameState = GameState(key: TOTAL_NODES+1, player: 2, state: newState, width: width, height: height)
                                newGameState.parentState = self
                                newGameState.lastMove = i
                            } else {
                                newState[i][j] = 2
                                newGameState = GameState(key: TOTAL_NODES+1, player: 1, state: newState, width: width, height: height)
                                newGameState.parentState = self
                                newGameState.lastMove = i
                            }
                            madeMove = true
                            childrenStates.append(newGameState)
                            
                        }
                    }
                }
            }
        }
    }
    
    /**
     Calculate Leaf Value
     
     Calculates the value of a node
     */
    func calculateLeafValue() {
        
        for i in 0 ..< WINNNING_MOVES.count {
            
            let move = WINNNING_MOVES[i]
            
            let index1 = move?[0]
            let index2 = move?[1]
            let index3 = move?[2]
            let index4 = move?[3]
            
            if state[(index1?[0])!][(index1?[1])!] == 1 && state[(index2?[0])!][(index2?[1])!] == 1 && state[(index3?[0])!][(index3?[1])!] == 1 && state[(index4?[0])!][(index4?[1])!] == 1 {
                
                if player == .max {
                    self.value = 100
                } else {
                    self.value = -100
                }
            }
            
            if state[(index1?[0])!][(index1?[1])!] == 2 && state[(index2?[0])!][(index2?[1])!] == 2 && state[(index3?[0])!][(index3?[1])!] == 2 && state[(index4?[0])!][(index4?[1])!] == 2 {
                
                if player == .min {
                    self.value = 100
                } else {
                    self.value = -100
                }
            }
        }
    }
    
    
    /**
     Print State
 
     Prints out the board
    */
    func printState() {
        var printItem = ""
        for i in 0 ..< height {
            for j in 0 ..< width {
                printItem += "\(state[j][i]) "
            }
            printItem += "\n"
        }
        
        print(printItem)
    }
}

/**
 Determine current move
 
 Determines if the current player was the first to go or the second
 */
func currentMove(state: [[Int]], height: Int, width: Int) -> Int {
    var totalMoves = 0
    
    for i in 0 ..< height {
        for j in 0 ..< width {
            if state[j][i] != 0 {
                totalMoves += 1
            }
        }
    }
    
    if totalMoves % 2 == 0 {
        return 1
    } else {
        return 2
    }
}

/**
 Calculate Winning Moves
 
 Determines all of the possible wins
 */
func calculateWinningMoves(width: Int, height: Int) {
    
    var moveIndex = 0

    
    // Calculate Horizontal Wins
    for i in 0 ..< height {
        for j in 0 ..< width-3 {
            let slots = [ [j, i], [j+1, i], [j+2, i], [j+3, i] ]
            WINNNING_MOVES[moveIndex] = slots
            moveIndex += 1
        }
    }
    
    // Calculate Verticle Wins
    for i in 0 ..< height-3 {
        for j in 0 ..< width {
            let slots = [ [j, i], [j, i+1], [j, i+2], [j, i+3] ]
            WINNNING_MOVES[moveIndex] = slots
            moveIndex += 1
        }
    }
    
    // Calculate Right Down Wins
    for i in 0 ..< height-3 {
        for j in 0 ..< width-3 {
            let slots = [ [j, i], [j+1, i+1], [j+2, i+2], [j+3, i+3] ]
            WINNNING_MOVES[moveIndex] = slots
            moveIndex += 1
        }
    }
    
    // Calculate Left Down Wins
    for i in 3 ..< height {
        for j in 0 ..< width-3  {
            let slots = [ [j, i], [j+1, i-1], [j+2, i-2], [j+3, i-3] ]
            WINNNING_MOVES[moveIndex] = slots
            moveIndex += 1
        }
    }
}


/**
 Build Tree
 
 Builds a tree based off of the root's children. Once a node's childen are all set, it sets that node's value depending on which player is making the move. 
 This is the implementation of the min/max algorithm because it sets up the node's value as it the tree is being wrapped back up.
 */
func buildTree(root: GameState, currentDepth: Int, maxDepth: Int, move: Int) -> GameState {
    
    if currentDepth == maxDepth {
        // Reached max depth
        root.calculateLeafValue()
        
        return root
    } else {
        root.generateChildren()
        
        var moves : [GameState] = []
        
        for child in root.childrenStates {
            if move == 1 {
                let newMove = buildTree(root: child, currentDepth: currentDepth+1, maxDepth: maxDepth, move: 2)
                moves.append(newMove)
                root.childrenValues.append(newMove.value)
            } else {
                let newMove = buildTree(root: child, currentDepth: currentDepth+1, maxDepth: maxDepth, move: 1)
                moves.append(newMove)
                root.childrenValues.append(newMove.value)
            }
            
        }
        
        root.childrenStates = moves
        
        if move == 1 {
            let maxIndex = root.childrenValues.index(of: .max)
            if maxIndex == nil {
                root.value = root.childrenValues[0]
                root.bestMove = root.childrenStates[0].lastMove
            } else {
                root.value = root.childrenValues.max()!
                root.bestMove = root.childrenStates[maxIndex!].lastMove
            }
        } else {
            let minIndex = root.childrenValues.index(of: .min)
            if minIndex == nil {
                root.value = root.childrenValues[0]
                root.bestMove = root.childrenStates[0].lastMove
            } else {
                root.value = root.childrenValues.min()!
                root.bestMove = root.childrenStates[minIndex!].lastMove
            }
        }
        
        return root
    }
}


/**
 Is Move Possible
 
 Double checks that the move about to be made is legal
 */
func isMovePossible(move: Int, state: [[Int]]) -> Bool {
    
    let column = state[move]
    
    if column[0] == 0 {
        return true
    }
    
    return false
}

/**
 Find first open column
 
 Finds the first open column in the state
 */
func findFirstOpenColumn(state: [[Int]]) -> Int {
    
    for i in 0 ..< state.count {
        let column = state[i]
        if column[0] == 0 {
            return i
        }
    }
    
    return -1
}


/**
 Get Data
 
 Import the Data from the driver program
 */
func getData() -> Dictionary<String, Any> {
    
    for argument in CommandLine.arguments {
        
        if let data = argument.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    return [:]
}

/**
 Send Data
 
 Write the data to stdout
 */
func sendData(_ move: Dictionary<String, Any>) {
    let stdout = FileHandle.standardOutput
    
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: move, options: [])
        stdout.write(jsonData)
    } catch {
        let string = "ERROR: Could not process dictionary"
        let data = string.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        stdout.write(data!)
    }
}

/**
 Write Error
 
 Write to the trace file
 */
func writeError(_ err: Dictionary<String, Any>) {
    let stderr = FileHandle.standardError
    
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: err, options: [])
        stderr.write(jsonData)
    } catch {
        let string = "ERROR: Could not process dictionary"
        let data = string.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        stderr.write(data!)
    }
}


/**
 
 The Main Procedure
 
 */


/**
 Load the data from the standard input and set the main procedure's base values
 */
let inData = getData()
let state : [[Int]] = inData["grid"] as! [[Int]]
let height = inData["height"] as! Int
let width = inData["width"] as! Int
PLAYER = inData["player"] as! Int

let onMove = currentMove(state: state, height: height, width: width)

/**
 Set up the program for implementtion of min-max
 */
calculateWinningMoves(width: width, height: height)
var nodeState = GameState(key: TOTAL_NODES, player: PLAYER, state: state, width: width, height: height)

/**
 Set up the children state
 */
nodeState.generateChildren()

/**
 Check to see if there is a block or win move
 */
var move = nodeState.findWinOrBlock()

/**
 If there is no block or win move, implement the min-max
 */
if move == -1 {
    var tree = buildTree(root: nodeState, currentDepth: 0, maxDepth: 5, move: onMove)
    
    move = tree.bestMove!
}

/**
 Double check if the move generated is possible. If not, set the move as the first open column
 */
if !isMovePossible(move: move, state: state) {
    move = findFirstOpenColumn(state: state)
    
    if move == -1 {
        move = width-1
    }
}

/**
 Set up the
 */
var moveData = Dictionary<String, Any>()
moveData["move"] = move

/**
 Write the information to the err file
*/
writeError(inData)
writeError(moveData)

/**
 Send the move back to the driver program
 */
sendData(moveData)
