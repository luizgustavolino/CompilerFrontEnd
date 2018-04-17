
// Temp.swift 

class Temp : Expr {

	// incrementador, para garantir 
	// novas variáives temp
	static var count = 0

	// number é o count atual 
	// na criação desta temp
	let number:Int

	init(withType type:Type) {

		Temp.count += 1
		number = Temp.count
		
		super.init(withToken: Word.temp, type: type)
	}

	// emite marcações: t1, t2 .. etc
	override func toString() -> String {
		return "t\(number)"
	}


}

