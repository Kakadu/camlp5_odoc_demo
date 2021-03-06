
module Cfg = Configurator.V1

(*** utility functions ***)

(* pretty dumb file reading *)
let read_file fn =
  let ichan = open_in fn in
  let rec helper lines =
    try
      let line = input_line ichan in
      helper (line :: lines)
    with End_of_file -> lines
  in
  let lines = List.rev @@ helper [] in
  String.concat "\n" lines

let extract_words = Cfg.Flags.extract_comma_space_separated_words

let string_match re s = Str.string_match re s 0

let match_fn_ext fn ext =
  String.equal ext @@ Filename.extension fn

(* scans `regression` folder looking for `test*.ml` files *)
let get_tests tests_dir =
  let re = Str.regexp "test*" in
  let check_fn fn =
       (string_match re fn)
    && (match_fn_ext fn ".ml")
    (* `dune` doesn't give us direct access to `source` folder, only to the `build` folder,
     * thus we have to exclude files generated by the preprocessor
     *)
    && (not @@ match_fn_ext (Filename.remove_extension fn) ".pp")
    (* `tester.ml` also should be excluded *)
    && (not @@ String.equal fn "tester.ml")
  in
     Sys.readdir tests_dir
  |> Array.to_list
  |> List.filter check_fn
  |> List.map Filename.remove_extension
  |> List.sort String.compare

(*** discovering ***)

let discover_tests _ tests =
  Cfg.Flags.write_lines "tests.txt" tests

let discover_camlp5_dir cfg =
  String.trim @@
    Cfg.Process.run_capture_exn cfg
      "ocamlfind" ["query"; "camlp5"]

let discover_camlp5_flags cfg =
  let camlp5_dir = discover_camlp5_dir cfg in
  let camlp5_archives =
    List.map
      (fun arch -> String.concat Filename.dir_sep [camlp5_dir; arch])
      ["pa_o.cmo"; "pa_op.cmo"; "pr_o.cmo"; "pr_dump.cmo" ]
  in
  Cfg.Flags.write_lines "camlp5-flags.cfg" camlp5_archives


(*** generating dune files ***)


(*** command line arguments ***)

let tests         = ref false
let tests_dune    = ref false
let tests_dir     = ref None
let camlp5_flags  = ref false
let gt_flags      = ref false
let logger_flags  = ref false
let all_flags     = ref false
let all           = ref false

let args =
  let set_tests_dir s = tests_dir := Some s in
  Arg.align @@
    [ ("-tests-dir"   , Arg.String set_tests_dir, "DIR discover tests in this directory"      )
    ; ("-tests"       , Arg.Set tests           , " discover tests (tests.txt)"               )
    ; ("-tests-dune"  , Arg.Set tests_dune      , " generate dune build file for tests"       )
    ; ("-camlp5-flags", Arg.Set camlp5_flags    , " discover camlp5 flags (camlp5-flags.cfg)" )
    ; ("-all-flags"   , Arg.Set all_flags       , " discover all flags"                       )
    ; ("-all"         , Arg.Set all             , " discover all"                             )
    ]

(*** main ***)

let () =

  Cfg.main ~name:"ocanren" ~args (fun cfg ->

    if !camlp5_flags || !all_flags || !all then
      discover_camlp5_flags cfg ;
    ()
  )
