# icarus.py
'''
Lexical Analyzer for Icarus
'''

# constants for the tokens
TT_INT      = 'TT_INT'
TT_FLOAT    = 'FLOAT'
TT_PLUS     = 'PLUS'
TT_MINUS    = 'MINUS'
TT_MUL      = 'MUL'
TT_DIV      = 'DIV'
TT_LPAREN   = 'LPAREN'
TT_RPAREN   = 'RPAREN'


class Token:

    def __init__(self, type_, value):
        ''' Class initializer '''
        self.type = type_
        self.value = value


    def __repr__(self):
        ''' Class representation'''
        if self.value:
            return f'{self.type}:{self.value}'
        
        return f'{self.type}'


class Lexer:
    def __init__(self, text):
        self.text = text
        self.pos = -1
        self.current = None
        self.advance()

    def advance(self):
        self.pos += 1
        
        if self.pos < len(self.text):
            self.current = self.text[pos]
        else:
            self.current = None

    