(** {1 blah} *)

(** {3 blah} *)
val x : int

(** Comment for exception My_exception, even with a simple comment
    between the special comment and the exception.*)
(* Hello, I'm a simple comment :-) *)
exception My_exception of (int -> int) * int
