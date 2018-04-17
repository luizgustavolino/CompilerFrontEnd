
// Env.swift

class Env {
	
	// Link entre tokens e o Parser, na geração 
	// da árvore sintática
	var table:[Token:Id] = [:]

	// Aponta para um escopo mais acima
	let prev:Env?

	init(withPrev n:Env?) {
		prev = n
	}

	func put(_ w:Token, _ i:Id) {
		table[w] = i
	}

	func get(_ w:Token) -> Id? {

		// Busca no escopo local
		// se não encontra procura
		// recursivamente nos
		// escopos prévios

		if let found = table[w] {
			return found
		}

		if let p = prev {
			return p.get(w)
		}

		return nil
	}
}