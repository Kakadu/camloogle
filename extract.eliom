
(*let mli = "/usr/local/lib/ocaml/3.12.1/ssl/ssl.mli" *)

let parse filename : Parsetree.signature_item list = 
  let ch = open_in filename in
  let buf = Lexing.from_channel ch in
  let intf = Parser.interface Lexer.token buf in
  close_in ch;
  intf

open Parsetree
open StdLabels
open Printf

let string_of_signature_item_desc = function
  | Psig_value _ -> "psigvalue"
  | Psig_type lst -> sprintf "psigtype: (%s)" (String.concat ~sep:"," (List.map fst lst))
  | Psig_class _ -> "psigclass"
  | _ -> "smth"

(*
let () = 
  let lst = parse mli in
  List.iter lst ~f:(fun {psig_desc; _ } -> 
    Printf.printf "%s\n" (string_of_signature_item_desc psig_desc)
  )
  *)

open Eliom_pervasives.HTML5

let print_core_type {ptyp_desc; ptyp_loc} = 
  match ptyp_desc with
    | Ptyp_any   -> M.span [M.pcdata "any"]
    | Ptyp_var s -> M.span [M.pcdata s]
    | Ptyp_arrow (label,_,_) -> M.span [M.pcdata (sprintf "arrow %s " label)]
    | _          -> M.span [M.pcdata "core_type"]

let print_db (db : Parsetree.signature) = 
  let open Parsetree in
  List.map db ~f:(fun valdesc ->
    match valdesc.psig_desc with
      | Psig_value (name,{pval_type;pval_prim}) -> 
          M.pre [M.span ~a:[a_class ["ocsforge_color_keyword"]] [M.pcdata "Psig_value"]
                ;print_core_type pval_type
                ;M.span [M.pcdata (String.concat "?" pval_prim)]
                ]
      | Psig_type lst ->
          M.pre (List.map (fun (name,decl) -> M.span [M.pcdata (sprintf " %s decl" name)]) lst)
      | _            -> M.pre [M.span [M.pcdata "something"]]
)



















