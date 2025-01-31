open Ecs
open Components
open Systems_def

let chara txt x y width height =
  let e = new character in
  e#texture#set txt;
  e#position#set Vector.{x= float x; y = float y};
  e#box#set Rect.{width; height};

  Draw_system.(register (e :> t));
  Move_system.(register (e :> t));
  e

let add_vel (c:character) v =
  let vel = c#velocity#get in
  
  c#velocity#set (Vector.add vel v);
  let vel2 = c#velocity#get in
  print_float vel2.x; print_newline ()
