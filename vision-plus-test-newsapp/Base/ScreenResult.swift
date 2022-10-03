//
//  ScreenResult.swift
//  vision-plus-test-newsapp
//
//  Created by Erwindo Sianipar on 03/10/22.
//

internal protocol ScreenResult {}

extension Int: ScreenResult {}
extension String: ScreenResult {}

extension NewsResponseModel: ScreenResult {}
