//
//  FeedUIFactory.swift
//  MainDispatchQueueDecoratoriOS
//
//  Created by Wilmer Barrios on 06/05/21.
//

import Foundation
import UIKit

public protocol FeedUIFactory {
    func makeFeedController() -> UIViewController
}
