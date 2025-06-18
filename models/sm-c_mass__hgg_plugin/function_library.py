
# This file was automatically created by The UFO_usermod        

import cmath
from object_library import all_functions, Function

complexconjugate = Function(arguments = ('z',),
                            expression = 'z.conjugate()',
                            name = 'complexconjugate')


re = Function(arguments = ('z',),
              expression = 'z.real',
              name = 're')


im = Function(arguments = ('z',),
              expression = 'z.imag',
              name = 'im')


sec = Function(arguments = ('z',),
               expression = '1./cos(z)',
               name = 'sec')


asec = Function(arguments = ('z',),
                expression = 'acos(1./z)',
                name = 'asec')


csc = Function(arguments = ('z',),
               expression = '1./sin(z)',
               name = 'csc')


acsc = Function(arguments = ('z',),
                expression = 'asin(1./z)',
                name = 'acsc')

