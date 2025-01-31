
(* A module to initialize and retrieve the global state *)
type t = {
  window : Gfx.window;
  ctx : Gfx.context;
  sm: State_machine.state_machine;
}

val get : unit -> t
val set : t -> unit
