//
//  CalendarVars.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/9/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import Foundation

let date = Date()
let calendar = Calendar.current

let day = calendar.component(.day , from : date)
let weekday = calendar.component(.weekday , from : date)
var month = calendar.component(.month , from : date) - 1
var year = calendar.component(.year , from : date)


