//
//  FileManager-Documents.swift
//  SnowSeeker
//
//  Created by Angel Vázquez on 30/12/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("This directory should always exist.")
        }
        return documents
    }
}
