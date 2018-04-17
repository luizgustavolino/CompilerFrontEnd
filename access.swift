
// Access.swift

class Access : Op {

	let array:Id
	let index:Expr

	// 'a' é o id da var
	// 'i' é a expr que resolve o índice 
	// 'p' é o tipo do vetor (int, float)
 	init(withId a:Id, _ i:Expr, _ p:Type) {

		array = a
		index = i

		let w = Word(withLexeme: "[]", tag: Tag.INDEX)
		super.init(withToken: w, type: p)
	}

	// Gen cria um Expr com o indice resolvido num
	// variável temp, quando necessário
	// arranjo[i + 2] fica:
	//   t6 = i + 2
	//   arranjo[t6] 
	override func gen() -> Expr {
		return Access(withId: array, index.reduce(), type)
	}

	// if arranjo[t6] goto t
	override func jumping(_ t:Int, _ f:Int) {
		emitjumps(reduce().toString(), t, f)
	}

	override func toString() -> String {
		return "\(array.toString()) [\(index.toString())]"
	}

}