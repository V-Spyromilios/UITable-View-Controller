//
//  UIImage Compress Extension.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 13.03.23.
//

import Foundation
import UIKit

extension UIImage {

	func compress(quality: CGFloat) -> Data? {

		guard let imageData = self.jpegData(compressionQuality: quality) else {
			print("PANIC: compressed() failed to compress image to Jpeg.")
			return nil
		}
		return imageData
	}
}
