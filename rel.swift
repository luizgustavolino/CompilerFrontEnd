
// Rel.swift

class Rel : Logical {

	func check (_ p1:Type, _ p2:Type) -> Type? {
		if p1 is Arrayy || p2 is Arrayy {
			return nil
		} else if p1 == p2 {
			return Type.Bool
		} else {
			return nil
		}
	}

	override func jumping(_ t:Int,_ f:Int) {
		let a = expr1.reduce()
		let b = expr2.reduce()
		let test = "\(a.toString()) \(op.toString()) \(b.toString())"
		emitjumps(test, t , f)
	}

}