//
//  constants.swift
//  AppState
//
//  Created by Justin Reusch on 4/22/19.
//

import Foundation
import AppState

// Default values for state testing
let initialName = "John Smith"
let initialCity: String? = nil
let initialAge = 36
let initialHeight = 178.5
let initialSignedInStatus = false
let initialEmployeeList = ["Bob Johnson", "Mary Smith", "Matt Johnson"]

// Default initial state
let initialState: StateMap = [
    "name": initialName,
    "city": initialCity,
    "age": initialAge,
    "height": initialHeight,
    "signedIn": initialSignedInStatus,
    "employeeList": initialEmployeeList
]
