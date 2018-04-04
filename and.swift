
// And.swift

class And : Logical {

	override func jumping(_ t:Int,_ f:Int) {
		let label = f != 0 ? f : newlabel()
		expr1.jumping(0, label)
		expr2.jumping(t, f)

		if f == 0 {
			emitlabel(label)
		}
	}

}