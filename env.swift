
// Env.swift

class Env {
	
	var table:[Token:Id] = [:]
	let prev:Env?

	init(withPrev n:Env) {
		prev = n
	}

	func put(_ w:Token, _ i:Id) {
		table[w] = i
	}

	func get(_ w:Token) -> Id? {
		if let found = table[w] {
			return found
		}

		if let p = prev {
			return p.get(w)
		}

		return nil
	}
}