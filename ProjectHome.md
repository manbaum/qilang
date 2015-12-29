1. What is Qi?

A language implemented in Common Lisp that generates efficient type secure Lisp programs which you can run on any machine.

2. What advantages does writing in Qi have over writing in Lisp?

Quite a few.

  1. Qi uses pattern-matching instead of forcing you to write in CARs and CDRs. Typically Qi programs have 40% of the non-whitespace characters that Lisp programs have.
> 2. Qi has optional static type checking. You don't have to pray your program will not crash with a type error in a real application.
> 3. Qi is lambda-calculus consistent. It makes Common Lisp understand things like partial applications.

3. If I choose Qi, do I have to give up Lisp?

Absolutely not. In fact you can mix Qi and Lisp functions into one file and load them together. You can use Lisp functions within Qi code with no problems. You can even add to the type discipline of Qi to tell it about the types of functions that you have written in Lisp and it will accept your information.

4. What advantages does writing in Qi have over writing in ML or Haskell?

  1. Qi runs on top of Lisp, which means that Qi inherits all the features of Lisp that ML and Haskell do not have; (think macros, EVAL, hash-tables, property-lists, metaprogramming ....)
> 2. Static typing is optional in Qi. You do not have to buy into it if you are dealing with code that is resistant to type checking. Or you can choose to check only that code you are interested in.
> 3. The type discipline of Qi is based on sequent notation which is a much more powerful and flexible tool for defining types than that used in ML or Haskell. To find out why [click here](http://www.lambdassociates.org/advtypes.htm).