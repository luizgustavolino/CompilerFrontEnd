
// Extension.swift

extension String {

    var unicodeScalarCodePoint:Int {
        let characterString = self.first!
        let scalars = characterString.unicodeScalars
        return Int(scalars[scalars.startIndex].value)
    }

    var isDigit:Bool {
    	switch self  {
    		case "0","1","2","3","4","5","6","7","8","9": return true
    		default: return false 
    	}
    }

    var isLetter:Bool {
    	return ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
    	        "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"].contains(self.lowercased())
    }

    var isLetterOrDigit:Bool {
    	return self.isLetter || self.isDigit
    }


}

extension Int {
	var stringFromUnicodeScalarCodePoint:String {
		return String(UnicodeScalar(UInt8(self)))
	}
}