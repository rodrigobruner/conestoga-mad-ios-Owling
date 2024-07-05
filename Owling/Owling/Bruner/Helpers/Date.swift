//
//  Date.swift
//  Owling
//
//  Created by user228347 on 6/28/24.
//

import Foundation

let defaultDateFormat = "E, d MMM yyyy HH:mm"

func daysUntilDate(_ date: Date) -> Int? {
    let calendar = Calendar.current
    let now = Date()
    let components = calendar.dateComponents([.day], from: now, to: date)
    return components.day
}
