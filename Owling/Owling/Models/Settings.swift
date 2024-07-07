//
//  settings.swift
//  Owling
//
//  Created by user228347 on 7/7/24.
//

import Foundation

struct Settings: Codable{
    var addSample:Bool = true
    var grupedByCategory:Bool = false
    var defaultDateFormat:String = "E, d MMM yyyy HH:mm"
}

let KeyForSettings = "settings123123"

func saveSettings(_ settings: Settings) {
    print("SaveSettings")
    let data = try? JSONEncoder().encode(settings)
    UserDefaults.standard.set(data, forKey: KeyForSettings)
}

func loadSettings() -> Settings {
    print("LoadingSettings")
    return UserDefaults.standard.object(forKey: KeyForSettings) as? Settings ?? Settings()
}

func deleteSettings(){
    UserDefaults.standard.removeObject(forKey: KeyForSettings)
}
