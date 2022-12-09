//
//  buildBranchUrlComponent.swift
//  Previous name: buildDailyRegisterUrlComponent
//
//  Created by Chris Kobrzak on 08/12/2022.
//

import Foundation

func buildBranchUrlComponent(branchId: Int, filter: String) -> URLComponents {
  let path = "/branches/\(branchId)"
  let queryItem = URLQueryItem(name: "filter", value: filter)

  return buildUrlComponent(path, queryItems: [queryItem])
}
