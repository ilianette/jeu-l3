open Ecs
open Global
open State_machine
open Systems_def
let window_spec = 
  Format.sprintf "ntm:%dx%d:"
    Cst.window_width Cst.window_height

class state1 (ch: Components.character) = object

  method enter (sm: state_machine) =
    print_endline "entering state 1";

    Input.connect_on_press   "q" (fun () -> Chara.add_vel ch Vector.{x= -10.; y=0.});
    Input.connect_on_release "q" (fun () -> Chara.add_vel ch Vector.{x=10.; y=0.});
    Input.connect_on_press   "d" (fun () -> Chara.add_vel ch Vector.{x=10.; y=0.});
    Input.connect_on_release "d" (fun () -> Chara.add_vel ch Vector.{x= -10.; y=0.});



  method leave  (sm: state_machine) =
    print_endline "leaving state 1";
    Input.disconnect "space";
    Input.disconnect "a"

  method update (dt: float) =
    Input.handle_input ();

    Draw_system.update dt;
    Move_system.update dt;   
end


    

let run () =
  let window : Gfx.window = Gfx.create window_spec in
  let ctx : Gfx.context = Gfx.get_context window in
  let chara = Chara.chara Texture.green 0 0 15 15 in
  
  
  
  Global.set
    { window=window
    ; ctx=ctx
    ; sm = init (new state1 chara)
    };
   
  Gfx.main_loop ~limit:true (update (get ()).sm) (fun () -> ())
  
