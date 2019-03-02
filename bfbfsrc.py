import io

_script = io.StringIO()

#{list1}[ ][ ][ ][ ][ ][ ][ ][ ][ ][ ]{list2}

_script.write('*hello info*\n')
_script.write('''++++[->++++++++<]>[->+>++>+++<<<]>>>[->+>+>+>+<<<<]+++++++[->>+>++>+++<<<<]
<++.>>>>>---.<<<+.>++.>.<---.>>+++.<<<++.>>---.<<<<<.>+++++++.>>>>+++.>-.<<<++.>>>--.<++.>.<<<.>>>++.<<<.>>>--.<<<<++++++++++.
>---.>>>+++++++.<<<<<<.>++++.>>+++.>>--.<+.<<<<.>-----.>>>>>------.++.<.<<<<<.>>>>>+.-.<<<<<.>--.>>.---.<<<.<<+++++++[->+++++++<]>+.+++++.>.<-----.--.+.++++++++.>>>.
>>++.>.++.>.-.<<<<<<.>>>>>>-.<<<+.>>>-.<<.>.>++.<<<<<<.>>>++.>>--.<<-.>.>.<--.<<<<.>>>>>>+++.<<++.>>---.<<-.<<<<.>>>>>.<<+.>>>+++.<--.<+.>++.<<.<<<<+.>>>.
>>>>[[-]<]''')

_script.write('*read script*\n')
_script.write('>,.input 1st\n')
_script.write('----------[++++++++++while ne 10(\'\\n\')\n')
_script.write('>+>,.set mark and input next\n')
_script.write('----------]while end\n')
_script.write('>')
_script.write('''+++++++++++[->++++++++++<]>[->+>+>+<<<]>++++.+++.>..>-----.<.>--.
[[-]<]+++++[->+++++++++<]>+...[-]++++++++++.[-]<<''')
_script.write('-\n')
_script.write('now script: (0)(s)(1)(s): : :(1)(s)(1)(0)(255^)\n')
_script.write('which s = script and ^ = head\n')


def load_script():
    """head must at :::(1/0^)(0)(255^)
    after head also at (255^)"""
    global _script
    _script.write('load script')
    _script.write('[<<]>')
    _script.write('[')
    _script.write('->+[->>+]->+')
    _script.write('<[<<]>')
    _script.write(']')
    _script.write('>+[->>+]-')
    _script.write('\n')


def save_script():
    """head must at :::(1/0^)(0)(255)(v^)
    after head also at (255)(v^)"""
    global _script
    _script.write('save script')
    _script.write('[-<[<<]>+>+[->>+]->]\n')

def next_script():
    """head must at :::(1/0^)(0)(-1^)"""
    global _script
    _script.write('next script')
    _script.write('[<<]+>>[->>+]-\n')


_script.write('*var def*\n')
_script.write('>')#v
_script.write('>')#0
_script.write('>-')#255
_script.write('>')#scp eq bool
_script.write('>')#scp ne bool
_script.write('>')
_script.write('>')
_script.write('>-')#tape border 255
_script.write('\n*virtual tape initialize*\n just like (^255)(b)(1)(b)(0):::\n')
_script.write('>>+' + '<' * 10 + '\n')
_script.write('now physical tape like this {:::(255^)(v)}(0)(255)(scp ne bool)(scp ne bool)(0)(out bool){(255):::}\n')


def tape_access():
    """head must at (^255)::: and return at :::(b)(1^)(b):::"""
    global _script
    _script.write('tape access')
    _script.write('-[+>>-]+\n')


def tape_back():
    """head must at any access point :::(b)(1/0^)(b)::: and return at (255^):::"""
    global _script
    _script.write('tape back')
    _script.write('+[-<<+]-\n')


def script_ne(ch: str):
    """head must at :::(255)(v^)(0)(255)(0target bool)(0target bool)
    after call head at :::(255)(v^)(0)(255)(0/1target bool)(0/1target bool)"""
    global _script
    _script.write('if script value eq %d(%s)' % (ord(ch), {
            '+': 'plus',
            '-': 'minus',
            '<': 'left shift',
            '>': 'right shift',
            ',': 'input',
            '.': 'print',
            '[': 'while',
            ']': 'end while'
        }[ch]))
    _script.write('-' * ord(ch))
    _script.write('[>>>+>+<<<]')
    _script.write('+[->+]-')#goto latter 255
    _script.write('<<' + '+' * ord(ch) + '\n')


_script.write('*read script operator*\n')
load_script()
_script.write('>[while script value ne 0*\n')

script_ne('+')
_script.write('>>>-[+if eq**\n')
_script.write('>' * 4 + '\n')
tape_access()
_script.write('<+<add 1\n')
tape_back()
_script.write('<' * 4 + '\n')
_script.write(']end if**\n')
_script.write('>[-if ne**\n')
_script.write('<' * 4 + '\n')

script_ne('-')
_script.write('>>>-[+if eq***\n')
_script.write('>' * 4 + '\n')
tape_access()
_script.write('<-<minus 1\n')
tape_back()
_script.write('<' * 4 + '\n')
_script.write(']end if***\n')
_script.write('>[-if ne***\n')
_script.write('<' * 4 + '\n')

script_ne('<')
_script.write('>>>-[+if eq****\n')
_script.write('>' * 4 + '\n')
tape_access()
_script.write('move access tag to left-<<if out left bound[>>]end if+\n')
tape_back()
_script.write('<' * 4 + '\n')
_script.write(']end if****\n')
_script.write('>[-if ne****\n')
_script.write('<' * 4 + '\n')

script_ne('>')
_script.write('>>>-[+if eq*****\n')
_script.write('>' * 4 + '\n')
tape_access()
_script.write('->>+move access tag to right\n')
tape_back()
_script.write('<' * 4 + '\n')
_script.write(']end if*****\n')
_script.write('>[-if ne*****\n')
_script.write('<' * 4 + '\n')

script_ne(',')
_script.write('>>>-[+if eq******\n')
_script.write('>' * 3 + '[-]+set output tag' + '\n')
_script.write('>' * 1 + '\n')
tape_access()
_script.write('<\n')
_script.write('[-]' + 'hint input(' + '+' * ord('\n') + '.'
              + '+' * (ord('<') - ord('\n')) + '.'
              + '-' * (ord('<') - ord(' ')) + '.)'
              + ',(.)input\n'
              )
_script.write('<\n')
tape_back()
_script.write('<' * 4 + '\n')
_script.write(']end if******\n')
_script.write('>[-if ne******\n')
_script.write('<' * 4 + '\n')

script_ne('.')
_script.write('>>>-[+if eq*******\n')
_script.write('>' * 3 + '\n[hint print(' + '+' * (ord('\n') - 1) + '.'
              + '+' * (ord('>') - ord('\n')) + '.'
              + '-' * (ord('>') - ord(' ')) + '.'
              + ')[-]]\n')
_script.write('>' * 1 + '\n')
tape_access()
_script.write('<.<print\n')
tape_back()
_script.write('<' * 4 + '\n')
_script.write(']end if*******\n')
_script.write('>[-if ne*******\n')
_script.write('<' * 4 + '\n')

script_ne(']')
_script.write('>>>-[+if eq********\n')
_script.write('>' * 4 + '\n')
tape_access()
_script.write('*use pos marked (c) as cache and the latter as while var*\n(v)(1)( )(0c)( )(0c):::\n')
_script.write('<[->>>+>>+<<<<<]>>>[-<<<+>>>]now head is at the former\n')
_script.write('>>[[-]if latter ne 0*********\n')
tape_back()
_script.write('<' * 8 + 'to :::(255^)\n')
_script.write('[<<]to opened pos mark\n')
_script.write('+set unopened\n')
_script.write('>' + '+' * (ord(']') - ord('[')) + 'set end while operator\n')
_script.write('[' + '+' * ord('[') + '<<' + '-' * ord('[') + ']' + '+' * ord('[')
              + 'goto while operator\n')
_script.write('<set access\n')
_script.write('[->>+]-goto 255 mark\n')
_script.write('>[-]set val to 0\n')
_script.write('>' * 7 + '\n')
tape_access()
_script.write('>>>>]end if*********\n')
tape_back()
_script.write('<' * 4 + '\n')
_script.write(']end if********\n')
_script.write('>[-if ne********\n')
_script.write('<' * 4 + '\n')

script_ne('[')
_script.write('>>>-[+if eq*********\n')
_script.write('<<<[-]' + 'clear val\n')
_script.write('<\n')
_script.write('[<<]+goto opened mark and set 1\n')
_script.write('>' + '-' * (ord(']') - ord('[')) + 'set while operator\n')
_script.write('[' + '+' * ord(']') + '>>' + '-' * ord(']') + ']' + '+' * ord(']') + 'goto end while\n')
_script.write('<<<set open mark to the operator before end while\n')
_script.write('[->>+]-goto (255)\n')
_script.write('>' * 4 + ']end if*********\n')

_script.write('>\n')
_script.write(']end if********\n')
_script.write(']end if*******\n')
_script.write(']end if******\n')
_script.write(']end if*****\n')
_script.write(']end if****\n')
_script.write(']end if***\n')
_script.write(']end if**\n')
_script.write('<' * 4 + '\n')
save_script()
_script.write('<\n')
next_script()
load_script()
_script.write('>]end while*\n')

_script.write('*end msg*\n')
_script.write('''++++++++++[->+>+++++++>++++++++++>+++++++++++<<<<]>.>+.>+++++.>.<.>+++++.<-.---.-.<[->>-<<]>>+.''')


print(_script.getvalue())
