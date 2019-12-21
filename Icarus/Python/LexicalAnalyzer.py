'''
Lexical Analyzer and Parser for Icarus
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



###################################################
# Nodes
###################################################
class NumberNodes:
    def __init__(self, tok):
        self.tok = tok
    
    def __repr__(self):
        return f'{self.tok}'

class BinaryOperation:
    def __init__(self, lft_node, op_tok, rht_node):
        self.lft_node = lft_node
        self.op_tok = op_tok
        self.rht_node = rht_node


    def __repr__(self):
        return f'({self.lft_node}, {self.op_tok}, {self.rht_node})'

class Parser:
    def __init__(self, tokens):
        self.tokens = tokens
        self.token_index = 1
        self.advance()

    def advance(self) -> int:
        self.token_index += 1
        if self.token_index < len(self.tokens):
            self.current_token = self.tokens[self.token_index]
        
        return self.current_token

    def parse(self):
        res = self.expr()

        return res


    def factor(self):
        tok = self.current_token

        if tok.type in (TT_INT, TT_FLOAT):
            self.advance()
            return NumberNodes(tok)

    def term(self):
        return self.binary_op(self.factor, (TT_MUL, TT_DIV))
    
    def expr(self):
        return self.binary_op(self.factor, (TT_PLUS, TT_MINUS))

    def binary_op(self, func, ops):
        left = func()

        while self.current_token.type in ops:
            op_tok = self.current_token
            self.advance()
            right = func()
            left = BinaryOperation(left, op_tok, right)

        return left
    
 
def run(fn: str, text: str):
    lexer = Lexer(fn, text)
    tokens, error = lexer.make_tokens()
    if error:
        return None, error

    parser = Parser(tokens)
    AbsTree = parser.parse()


    return AbsTree, None
    
            