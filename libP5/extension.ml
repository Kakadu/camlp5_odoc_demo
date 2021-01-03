(* LICENCE *)

(** {1 Camlp5 syntax extension for miniKanren syntax constructs}

  There are two syntax extensions provided: [fresh] and [defer].

  [fresh] is a direct analog to the corresponding construct in original miniKanren. It has the form
  [fresh (x y ...) g], where [x y ...] is a list of free variables, created by [fresh], [g] --- some goal.

  [defer] performs "inverse-eta-delay". It has the form [defer (g)] and expanded into [fun st -> Lazy.from_fun (fun () -> g st)].
*)

(**/**)

#load "pa_extend.cmo";;
#load "q_MLast.cmo";;


open Pcaml
open Printf
