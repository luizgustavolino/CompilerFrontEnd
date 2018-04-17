
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

		// Reduce traduz
		// de: Rel( >=, Arith(3+2), Expr(4) )
		// para: Rel ( >= , t5, Expr(4))
		let a = expr1.reduce()
		let b = expr2.reduce()

		// Emite, por exemplo, para t != 0:
		// if t5 >= 4 goto t
		let test = "\(a.toString()) \(op.toString()) \(b.toString())"
		emitjumps(test, t , f)
	}

}