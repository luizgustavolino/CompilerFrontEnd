
// Op.swift

class Op : Expr {
	override func reduce() -> Expr {
		let x = gen()
		let t = Temp(withType: type)
		emit("\(t.toString()) = \(x.toString())")
		return t
	}

}
