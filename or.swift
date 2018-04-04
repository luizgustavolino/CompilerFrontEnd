

// Or.swift

class Or : Logical {

	override func jumping(_ t:Int,_ f:Int) {
		let label = t != 0 ? t : newlabel()
		expr1.jumping(label, 0)
		expr2.jumping(t, f)

		if t == 0 {
			emitlabel(label)
		}
	}

}