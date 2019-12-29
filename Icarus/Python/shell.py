import LexicalAnalyzer

while True:
		text = input('LexicalAnalyzer > ')
		result, error = LexicalAnalyzer.run('<stdin>', text)

		if error: print(error.as_string())
		else: print(result)