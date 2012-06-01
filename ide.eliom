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

module CSSHelp = struct
  let sizes = sprintf "min-width: %dpx; min-height: %dpx; max-width: %dpx; max-height: %dpx; "
  let widnhei = sprintf "width: %s; height: %s; "
  let margin = sprintf " margin: %dpx %dpx %dpx %dpx; "
  let size_style = sizes 0 0 10000 10000
end

let topbar = 
  let open CSSHelp in
  let str2 = (widnhei "100%" "100%")^"display: -moz-box; -moz-box-orient: horizontal; -moz-box-sizing: border-box; -moz-box-align: stretch; padding: 0px; -moz-box-pack: start; overflow: visible;" in
  let menu_hbox_style = "display: -moz-box; -moz-box-orient: horizontal; -moz-box-sizing: border-box; -moz-box-align: center; padding: 8px 5px 0px; overflow: visible;" 
    ^ (sizes 0 0 10000 10000) ^ "-moz-box-pack: start; margin: 0px; height: auto;" in(*
  let str3 = "width: 100%; height: 100%; display: -moz-box; -moz-box-orient: horizontal; -moz-box-sizing: border-box; -moz-box-align: stretch; padding: 0px; -moz-box-pack: start; overflow: visible;" in *)
  let str4 = "-moz-box-sizing: border-box; display: -moz-box; -moz-box-orient: vertical; width: 0px; overflow: hidden; -moz-box-flex: 1;" ^ (sizes 1 1 10000 10000) in

  let open HTML5.M in
  let menuitems = 
    let topmenu_style = "margin: 1px 3px 0px 0px; -moz-box-sizing: border-box;" ^ (sizes 1 1 10000 10000 )in
    List.map (fun x ->
      div ~a:[a_style topmenu_style; 
              a_class ["c9-menu-btn";"c9-menu-btnBool"(*; "c9-menu-btnDown";"c9-menu-btnmenuDown";
                       "c9-menu-btnDown";"c9-menu-btnmenuDown"*)]] 
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

let mainbar = 
  let open HTML5.M in
  let open CSSHelp in

  div ~a:[a_class ["hbox"]
         ;a_style ("display: -moz-box; -moz-box-orient: horizontal; -moz-box-sizing: border-box; -moz-box-align: stretch; padding: 0px; -moz-box-flex: 1; overflow: visible;" ^ (widnhei "1" "1") ^ (sizes 0 0 1000 10000) ^ " -moz-box-pack: start; margin: 0px;")
         ]
    [div ~a:[a_class ["vbox";"black-menu-bar";"unselectable"]
            ;a_style ("display: -moz-box; -moz-box-orient: vertical; -moz-box-sizing: border-box; -moz-box-align: stretch; " ^ (sizes 0 0 10000 10000) ^ "padding: 0px; -moz-box-pack: start; margin: 0px; height: 1px; overflow: visible;")
             ] (* vertical menu on left *)
        ( let img = "ide/project_files.png" in
          List.map (fun (name,clas,_icon) ->
            div ~a:[a_class ["mnubtn";"mnubtnBool";clas]
                   ;a_style 
                     ("-moz-box-sizing: border-box; "^(sizes 1 1 10000 10000)^"margin: 0px; width: auto;")
                   ]
              [div ~a:[a_class ["icon"]] []
              ;div ~a:[a_class ["pointer"]] []
              ;span [pcdata name]
              ]
          ) [("Project Files","project_files",img)
            ;("Open Files","open_files",img)
            ;("Run","rundebug",img)
            ;("Deploy","deploy", img)
            ;("Preferences","preferences",img)
            ]
        )
    ;div ~a:[a_class ["vbox"; "fm-window"]
            ;a_id "q3"
            ;a_style 
              (sizes 1 0 10000 9970 ^ 
               "z-index: 9015; -moz-box-sizing: border-box; -moz-box-flex: 1; width: 200px; margin: 0px;")
            ] (* file list*)
      [div ~a:[a_class ["fm-header"]]
          [div ~a:[a_class ["hcontent"]] 
              [pcdata "Project Files"
              ;div ~a:[a_class ["icon"]] []
              ;div ~a:[a_class ["buttons"]]
                [div ~a:[a_class ["close"]] []
                ]
              ]
          ;div ~a:[a_class ["right"]] []
          ]
      ;div ~a:[a_class ["fm-content"]; a_id "q13"]
        [div ~a:[a_class ["vbox"]
                ;a_id "q46"
                ;a_style ((sizes 1 1 10000 10000) 
                          ^"position: absolute; left: 0px; right: 0px; top: 0px; bottom: 0px;" 
                          ^(widnhei "100%" "100%")^ "display: -moz-box; -moz-box-orient: vertical; -moz-box-sizing: border-box; -moz-box-align: stretch; padding: 0px; -moz-box-pack: start; overflow: visible; display: -moz-stack; -moz-box-orient: vertical; overflow: hidden; -moz-box-flex: 1; position: relative;"
                )
                ]
            [div ~a:[a_style ((widnhei "100%" "100%")^"display: -moz-box; -moz-box-orient: vertical; -moz-box-sizing: border-box; -moz-box-align: stretch; padding: 0px; -moz-box-pack: start; overflow: visible;")
                    ]
                [div ~a:[a_style ("-moz-box-sizing: border-box; display: -moz-stack; -moz-box-orient: vertical; height: 0px; overflow: hidden; -moz-box-flex: 1;" ^ (sizes 1 1 10000 10000)^ "position: relative;")]
                    [div ~a:[a_id "q49"
                            ;a_class ["filemgr-tree";"filemgr-treeFocus"]
                            ;a_style 
                              ("border-width: 0px; -moz-box-sizing: border-box; -moz-box-flex: 1;"
                               ^(widnhei "1px" "1px") ^ (sizes 1 1 10000 10000) )
                            ]
                        [div ~a:[a_id "2|2|153"
                                ;a_class ["item-fix";"last";"root";"pluslast";"indicate";"selected"]
                                ] (* root of file list*)
                            [div ~a:[a_class ["item"]]
                                [div ~a:[a_class ["label-content"]]
                                    [label ~a:[a_style "background-image:url(http://d6ff1xmuve0sx.cloudfront.net/1.9.10-c1e13656/static//ext/main/style/icons/folder.png)"
                                              ]
                                        (* NB it seems u is not supported *)
                                        []
                                    ;i ~a:[a_class ["caption"]] [pcdata "test1"]
                                    ]
                                ]
                            ]
                        ;div ~a:[a_class ["last";"root";"pluslast"]
                                ;a_style "display: block; height: auto; overflow: visible;"
                                ;a_id "q78"
                                ]
                          (List.map (fun x ->
                            div ~a:[a_class ["item-fix"]]
                              [div ~a:[a_class ["item"]]
                                  [span []
                                  ;div ~a:[a_class ["label-content"]]
                                    [label ~a:[a_style 
                                                  (sprintf "background-image:url(%s); "
"http://d6ff1xmuve0sx.cloudfront.net/1.9.10-c1e13656/static//ext/main/style/icons/page_white_code.png")
                                              ]
                                        [a ~a:[a_class ["caption"]] [pcdata x]
                                        ]
                                    ]
                                  ]
                              ]
                           ) ["filename1";"filename2";"Makefile"]
                          )                          
                        ]
                    ]
                ]
            ]
        ]
      ]
    ;div ~a:[a_class ["splitter";"splitterRealtime";"vertical";"w-resize"]
            ] (* splitter *)
      []
    ;div ~a:[a_class ["basic"]
            ;a_id "q6"
              ;a_style ("padding: 0pt 0pt 32px; position: absolute;" 
                        ^(sizes 1 0 10000 9968)
                        ^" left: 352px; top: 36px; width: 1014px; height: 316px;")
            ] (* editor *)
      [div ~a:[a_style 
                  ("-moz-box-sizing: border-box; display: -moz-box; -moz-box-orient: vertical;"
                   ^"width: 0px; -moz-box-flex: 1; " ^ (sizes 0 0 10000 10000))
              ;a_id "q4"
              ;a_class ["editor_tab";"infraeditor"]
              ]
          [div ~a:[a_class ["btnsesssioncontainer";"scale"]
                  ;a_id "82_buttons"] 
              [div ~a:[a_class ["session_btn";"btnclose";"firstbtn";"firstcurbtn";"curbtn"]
                      ;a_style "width: 130px;"
                      ]
                  [div ~a:[a_class ["tab_left"]] []
                  ;div ~a:[a_class ["tab_middle"]] 
                    [div ~a:[a_class ["sessiontab_icon"]] []
                    ;div ~a:[a_class ["sessiontab_title"]; a_title "main.ml"] [pcdata "main.ml"]
                    ;div ~a:[a_class ["sessiontab_saving"]] []
                    ;strong ~a:[a_style ("background-image: url(\"http://d6ff1xmuve0sx.cloudfront.net/1.9.10-c1e13656/static//ext/main/style/images/close_tab_btn.png\"); ")
                               ]
                      []
                    ]
                  ;div ~a:[a_class ["tab_right"]] []
                  ]
              ;div ~a:[a_id "q5"
                      ;a_class ["btn_icon_only";"btn_icon_onlyEmpty"]
                      ;a_style 
                        (
let url="http://d6ff1xmuve0sx.cloudfront.net/1.9.10-c1e13656/static//ext/main/style/images/plustabbtn.png" in
                          "display: inline-block; margin: 0pt 0pt 5px 13px; " ^ 
                         (sprintf "background-image: url(\"%s\");" url)
                         ^" background-repeat: no-repeat; min-width: 1px; min-height: 1px; max-width: 10000px; max-height: 10000px; width: 30px; height: 17px; background-position: 0px 0pt;")
                      ]
                []
              ]
          ;div ~a:[a_class ["editor-bg"]]
                      []
          ;div ~a:[a_class ["draganddrop"]
                  ;a_id "tabEditorsDropArea"
                  ]
            []
          ;div ~a:[a_id "q35"
                  ;a_class ["session_page";"curpage"]
                  ;a_style (sizes 1 0 10000 9997)
                  ]
            [div ~a:[a_class ["ce";"ace_editor";"ace-tomorrow"] 
                    ;a_style 
                      ("font-size: 16px; "^ 
                          (sizes 1 1 10000 10000) ^ 
                          "display: block; position: absolute; left: 0px; right: 0px; top: 2px; bottom: 0px;"
                      )
                    ]
                []
            ]
          ]
      ]
    ]
  
  
let ide_content project () =
      let open HTML5.M in
      Lwt.return
        (html default_head
           (body ~a:[a_style ("display: block; " ^ (CSSHelp.sizes 1 1 10000 10000))
                    ;a_id "q0"
                    ]
              [ topbar
              ; mainbar
              ]
           )
        )
