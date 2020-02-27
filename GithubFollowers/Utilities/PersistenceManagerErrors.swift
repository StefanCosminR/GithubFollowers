//
//  PersistenceManagerErrorMessages.swift
//  GithubFollowers
//
//  Created by Stefan Romanescu on 27/02/2020.
//  Copyright © 2020 StefanCosmin. All rights reserved.
//

enum PersistenceManagerErrors: String, Error {
    case unableToFavorite = "There was an error favoriting this user. Please try again"
    case alreadyInFavorites = "You've already favorite this user"
}

