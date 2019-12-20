# icarus.py
'''
Lexical Analyzer for Icarus
'''
# DIgits
DIGITS = '0123456789'

# constants for the tokens
TT_INT      = 'INT'
TT_FLOAT    = 'FLOAT'
TT_PLUS     = 'PLUS'
TT_MINUS    = 'MINUS'
TT_MUL      = 'MUL'
TT_DIV      = 'DIV'
TT_LPAREN   = 'LPAREN'
TT_RPAREN   = 'RPAREN'


class Error:
    def __init__(self, pos_start, pos_end, error, details):
        self.pos_start = pos_start
        self.pos_end = pos_end
        self.error = error
        self.details = details

    def as_string(self):
        result = f'{self.error}: {self.details}'
        result += f'File {self.pos_start.fn}, line {self.pos_start.ln + 1}'
        return result

class IllegalChar(Error):
    def __init__(self, pos_start, pos_end, details):
        super().__init__(pos_start, pos_end, "Illegal Character", details)


class position:
    def __init__(self, index, ln, col, fn, ftext):
        self.fn = fn
        self.ftext = ftext
        self.index = index
        self.ln = ln
        self.col = col

    def advance(self, current_char):
        self.index += 1
        self.col += 1

        if current_char == '\n':
            self.ln += 1
            self.col = 0
        
            return self

    def copy(self):
        return position(self.index, self.ln, self.col, self.fn, self.ftext)




class Token:
    def __init__(self, type_, value=None):
        ''' Class initializer '''
        self.type = type_
        self.value = value


    def __repr__(self):
        ''' Class representation'''
        if self.value:
            return f'{self.type}:{self.value}'
        
        return f'{self.type}'


class Lexer:
    def __init__(self, fn, text):
        self.fn = fn
        self.text = text
        self.pos = position(-1, 0, -1, fn, text)
        self.current = None
        self.advance()

    def advance(self):
        self.pos.advance(self.current)
        
        if self.pos.index < len(self.text):
            self.current = self.text[self.pos.index]
        else:
            self.current = None

    def make_tokens(self):
        tokens = []

        while self.current != None:
            if self.current in ' \t':
                self.advance()
            elif self.current in DIGITS:
                tokens.append(self.makeNum())
            elif self.current == '+':
                tokens.append(Token(TT_PLUS))
                self.advance()
            elif self.current == '-':
                tokens.append(Token(TT_MINUS))
                self.advance()
            elif self.current == '*':
                tokens.append(Token(TT_MUL))
                self.advance()
            elif self.current == '/':
                tokens.append(Token(TT_DIV))
                self.advance()
            elif self.current == '()':
                tokens.append(Token(TT_LPAREN))
                self.advance()
            elif self.current == ')':
                tokens.append(Token(TT_RPAREN))
                self.advance()
            else:
                position_start = self.pos.copy()

                err = self.current
                self.advance()
                return [], IllegalChar(position_start, self.pos, " ' " + err + " ' ")
                

        return tokens, None

    def makeNum(self):
        num_str = ''
        dots = 0
        while self.current != None and self.current in DIGITS + '.':
            if self.current == '.':
                if dots == 1:
                    break
            else:
                num_str += self.current
            self.advance()

        if dots == 0:
            return Token(TT_INT, int(num_str))
        else:
            return Token(TT_FLOAT, float(num_str))


def run(fn: str, text: str) -> list:
    lexer = Lexer(fn, text)
    tokens, error = lexer.make_tokens()

    return tokens, error

            