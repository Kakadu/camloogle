open Printf 

let default_head = 
  let open HTML5.M in
  let open Eliom_output in
  (head 
     (title (pcdata "IDE"))   
     [
       Html5.css_link ~uri:(XML.uri_of_string "style.css") ();
       Html5.css_link ~uri:(XML.uri_of_string "ide.css") ()
     ]
  )


let topbar = 
  let sizes = sprintf "min-width: %dpx; min-height: %dpx; max-width: %dpx; max-height: %dpx; " in
  let widnhei = sprintf "width: %s; height: %s; " in
  let margin = sprintf " margin: %dpx %dpx %dpx %dpx; " in
  let size_style = sizes 0 0 10000 10000 in
  let str2 = (widnhei "100%" "100%")^"display: -moz-box; -moz-box-orient: horizontal; -moz-box-sizing: border-box; -moz-box-align: stretch; padding: 0px; -moz-box-pack: start; overflow: visible;" in
  let menu_hbox_style = "display: -moz-box; -moz-box-orient: horizontal; -moz-box-sizing: border-box; -moz-box-align: center; padding: 8px 5px 0px; overflow: visible;"
    ^ (sizes 0 0 10000 10000) ^ "-moz-box-pack: start; margin: 0px; height: auto;" in
  let str3 = "width: 100%; height: 100%; display: -moz-box; -moz-box-orient: horizontal; -moz-box-sizing: border-box; -moz-box-align: stretch; padding: 0px; -moz-box-pack: start; overflow: visible;" in
  let str4 = "-moz-box-sizing: border-box; display: -moz-box; -moz-box-orient: vertical; width: 0px; overflow: hidden; -moz-box-flex: 1;" ^ (sizes 1 1 10000 10000) in

  let open HTML5.M in
  let menuitems = 
    let topmenu_style = "margin: 1px 3px 0px 0px; -moz-box-sizing: border-box;" ^ (sizes 1 1 10000 10000 )in
    List.map (fun x ->
      div ~a:[a_style topmenu_style; 
              a_class ["c9-menu-btn";"c9-menu-btnBool"; "c9-menu-btnDown";"c9-menu-btnmenuDown";
                       "c9-menu-btnDown";"c9-menu-btnmenuDown"]] 
        [ div ~a:[a_class ["c9-left"]] []
        ; div ~a:[a_class ["c9-label"]] [pcdata x]
        ; div ~a:[a_class ["c9-right"]] []
        ]
  ) ["File";"Edit";"View";"Windows";"Help"] in

  let toolbaritems =
    let sss = "http://d6ff1xmuve0sx.cloudfront.net/1.9.10-c1e13656/static//ext/main/style/icons/run.png" in
    let divide = div ~a:[a_class ["c9-divider-double"];
                         a_style ((margin 0 3 0 0)^(sizes 0 0 10000 10000)^"-moz-box-sizing:border-box;")
                        ] [div []] in
    let ans = List.map (fun sort ->
      match sort with
        | `Icon (title,url) ->
            div ~a:[a_class ["c9-toolbarbutton";"c9-toolbarbuttonIcon";"c9-toolbarbuttonEmpty"]
                   ;a_title title
                   ;a_style ((margin 0 3 0 0) ^ (sizes 1 1 10000 10000) ^ "-moz-box-sizing: border-box;")
                   ]
              [div ~a:[a_class ["c9-icon"]; a_style (sprintf "background-image: url(%s);" url)] [] ]
        | `DropDown items ->
            let (title,url) = List.hd items in
            div ~a:[a_style ((sizes 1 1 10000 10000) ^ "-moz-box-sizing: border-box; margin: 0px;")]
              [div ~a:[a_class ["c9-dropdown-btn";"main";"primary";"c9-dropdown-btnIcon"]
                      ;a_style (sizes 0 0 9999 9998)
                      ;a_title title]
                  [div ~a:[a_class ["c9-toolbarbutton";"c9-toolbarbuttonIcon";"c9-toolbarbuttonEmpty"]
                          ;a_style (sprintf "background-image: url(%s);" url)] []
                  ;div ~a:[a_class ["c9-label"]] [pcdata title]
                  ;div ~a:[a_class ["c9-arrow"]] []
                  ]
              ]
    ) [`Icon ("Open",
              "http://d6ff1xmuve0sx.cloudfront.net/1.9.10-c1e13656/static//ext/main/style/icons/open.png")
      ;`Icon ("Save",
              "http://d6ff1xmuve0sx.cloudfront.net/1.9.10-c1e13656/static//ext/main/style/icons/save.png")
(*      ;`DropDown [("1",sss); ("2",sss); ("3",sss); ("4",sss)] *)
      ]
    in
    divide :: ans      
  in

    (div ~a:[a_class ["c9-menu-bar"]]
       [div ~a:[a_class ["c9-mbar-logo"]]
           [ div ~a:[a_class ["c9-mbar-bcont"]]
               [ div ~a:[a_class ["c9-mbar-cont"] (* menu *) ]
                   [ div 
                       ~a:[a_class ["hbox"]; a_style size_style ]
                       [ div ~a:[a_style str2]
                           [ div (* menu *) ~a:[a_class ["hbox"]; a_style menu_hbox_style]
                             menuitems
                           ; div (* toolbar *) ~a:[a_id "q29"; a_class ["hbox"]; a_style menu_hbox_style]
                             toolbaritems
                           ; div (* space *) ~a:[a_style str4] []
                           ]
                       ]                       
                   ]
               ; a   ~a:[a_class ["mainlogo"]; a_title "Back to Dashboard"; a_target "_blank"] 
                 [pcdata "Dashboard"] (* logo *)
               ; div ~a:[a_class ["c9-mbar-round"]] [] (* delim *)
               ]
           ]
       ]
    )
  
let ide_content projectname () =
      let open HTML5.M in
      Lwt.return
        (html default_head
           (body ~a:[a_style "display: block; min-width: 1px; min-height: 1px; max-width: 10000px; max-height: 10000px;"]
              [ topbar
                 ; div [h1 [pcdata projectname]]
                 ; div []
                 ]
           )
        )
