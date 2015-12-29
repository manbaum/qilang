# Introduction #

The Qi language is a pattern matched, lambda calculus consistent version of Common Lisp with optional strong typing. It extends Common Lisp while providing access from Qi back to the underlying Lisp system. It works on a wide variety of Common Lisp implementations and operating systems and is designed for maximum portability.

Qi was designed by Lambda Associates with Dr. Mark Tarver as the main implementer. Over the past few years it has grown a small community of adherents who are diligently working on expanding Qi and enhancing the power of Lisp.

A functional language is lambda calculus consistent if it supports currying and the treatment of applications as first class objects in the manner of the lambda calculus.  The latter requires that an application can itself be applied like any other function if that application returns a function as a value.

Qi in this sense is lambda calculus consistent.  Common Lisp is not since currying is not supported, nor does Common Lisp permit expressions such as ((identity '+) 3 4) where identity is the identity function (CL requires FUNCALL to be used - (FUNCALL (identity '+) 3 4).

Qi is lambda calculus consistent.

The advantages of lambda calculus consistency is that it promotes the uniformity of the treatment of expressions and permits the use of a type theory based on the simply typed lambda calculus. Since most modern statically typed functional programming languages incorporate this type theory as a proper part, lambda calculus consistency makes for a standard and well-understood type theory.

# Details #

## Features ##

  * [Lambda Calculus Consistency](LambdaConsistent.md)
  * [Pattern Matching](PatternMatching.md)
  * (optional)[Strong Typing](StrongTyping.md)
  * [Native Sequent Calculus Evaluation](SequentCalculus.md)
  * [Backtracking](Backtracking.md)
  * Access to All [Common Lisp](CommonLisp.md) Functions