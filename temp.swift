
// Temp.swift 

class Temp : Expr {

	static var count = 0
	let number:Int

	init(withType type:Type) {

		Temp.count += 1
		number = Temp.count
		
		super.init(withToken: Word.temp, type: type)
	}

	override func toString() -> String {
		return "t\(number)"
	}


}

