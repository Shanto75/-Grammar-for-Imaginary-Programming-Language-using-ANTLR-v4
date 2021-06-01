grammar shanto;
root : headerfile+define_variable*define_fun*function;

headerfile:'@'header_instruction'['headerfile_name'].';
header_instruction: 'include'|'define'|'import';
headerfile_name:name|(name(.|'as')name);
define_fun: function_type name'['  (variable_type name)? (','variable_type name)*  '].';
define_variable: variable_type  expressions | variable_type name '.' ;
function:main_fun extra_fun* ;
main_fun: function_type 'main' '[' ']' body;
extra_fun: function_type name'[' (variable_type name)? (','variable_type name)* ']' body;
body: '{' statement '}';
statement: (define_variable | expressions  | print_data
            | get_input | decision | loops | return | call_fun)+  ;

expressions : '(' expressions ')'
                |variable_type? name (arithmetic_operator|assignment_operators) name_word_number
                 ((arithmetic_operator|assignment_operators) name_word_number)* '.';

call_fun: variable_type? name '=' name'[' name_word_number? (',' name_word_number)* '].' ;
print_data : 'show''[' name '].';
get_input : variable_type? name '=' 'read''[''].' ;
decision : if|elseif;
if: 'if''[' condition ']' body ('else' body)? ;
elseif: 'else if''[' condition ']' body ;
loops : whenloop|rangeloop;
whenloop: 'when' '[' condition ']' body  ;
rangeloop: 'range''[' name_word_number 'to' name_word_number ']' body ;
return: 'return' name_word_number '.';

condition:(name_word_number (relational_operators | arithmetic_operator ) name_word_number )
            ((logical_operators|arithmetic_operator|relational_operators) name_word_number )* ;

logical_operators: 'and' | 'or';
relational_operators: '=='|'!='|'>'|'<'|'>='|'<=';
assignment_operators: '=' | '+=' | '-=' | '*=' | '/='
                        | '%=' | '>>=' | ' <<=' | '&=' | '^=' | '|=';

arithmetic_operator: '+' | '-' | '*' | '/' | '%';
function_type:'int '|'float '|'bool '|'char '|'void ';
variable_type:'int '|'float '|'bool '|'char ';

name : Word+ Word*Number*;
name_word_number: (Number|Word|name);
Word:Letter+;
Number: Digit+|(Digit+'.'Digit+);
Digit : [0-9];
Letter : [a-zA-Z];
As : [ \t\r\n]+ -> skip ;
