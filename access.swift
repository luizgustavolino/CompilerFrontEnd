
// Access.swift

class Access : Op {

	let array:Id
	let index:Expr

	init(withId a:Id, _ i:Expr, _ p:Type) {
		array = a
		index = i

		let w = Word(withLexeme: "[]", tag: Tag.INDEX)
		super.init(withToken: w, type: p)
	}


	override func gen() -> Expr {
		return Access(withId: array, index.reduce(), type)
	}

	override func jumping(_ t:Int, _ f:Int) {
		emitjumps(reduce().toString(), t, f)
	}

	override func toString() -> String {
		return "\(array.toString()) [\(index.toString())]"
	}

}