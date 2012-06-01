open Eliom_pervasives
module App = Eliom_output.Eliom_appl (struct
  (* must be the name of the .js file *)
  let application_name = "app"
end)

let default_head = 
  let open HTML5.M in
  let open Eliom_output in
  (head 
     (title (pcdata "Demo"))   
     [ Html5.css_link ~uri:(XML.uri_of_string "ocsiwikistyle.css") ()
     ; Html5.css_link ~uri:(XML.uri_of_string "struct.css") ()
     ]
  )

{client{
(*  let _ = Dom_html.window##alert(Js.string "Hello") *)
}}

let db = Extract.parse "/usr/local/lib/ocaml/3.12.1/ssl/ssl.mli"

let main_service =
  App.register_service ~path:[""] ~get_params:Eliom_parameters.unit
    (fun () () -> 
      let open HTML5.M in
      Lwt.return
        (html default_head
            (body [
              h1 [pcdata "Graffiti"]
            ])
        )
    )

let search_servive = 
  let module EP = Eliom_parameters in
  App.register_service ~path:["search"] ~get_params:(EP.string "request")
    (fun s () ->
      let open HTML5.M in
      Lwt.return
        (html default_head
           (body [
             div (Extract.print_db db)
(*             H.h1 [H.pcdata s]*)
           ])
        )
    )

let ide_servive = 
  let module EP = Eliom_parameters in
  App.register_service ~path:["ide"] ~get_params:(EP.string "project")
    Ide.ide_content
    
    
