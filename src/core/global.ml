type t = {
  window : Gfx.window;
  ctx : Gfx.context;
  sm: State_machine.state_machine;
  }

let global = ref None

let set s = global := Some s
let get () = match !global with
  | None -> failwith "no global"
  | Some g -> g
