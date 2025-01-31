(*
implementation of a state machine.
All changes made to the state machine will be effective at the next update call.
It is recommanded to keep states data outside of the structure (otherwhise you will loose data between pops & pushes.
 *)


type transition_type = Enter | Leave

type state = < enter : state_machine -> unit; leave : state_machine -> unit; update : float -> unit>
and transition = state * transition_type
and state_machine = StateMachine of state list ref * transition list ref

  
let push sm s = match sm with
  | StateMachine( _, ts ) ->
     ts := (s, Enter)::!ts

let pop sm = match sm with
  | StateMachine ( { contents=s::_  }, ts) ->
     ts := (s, Leave)::!ts 
  | _ -> failwith "poping empty state machine"

let change_state sm =
  let aux sm s = push sm s; pop sm
  in aux sm

let clear sm = match sm with
  | StateMachine(s,_) -> List.iter (fun s -> s#leave sm) !s;

                         s := []
let init init_state =
  let sm = StateMachine (ref [], ref []) in
  push sm init_state;
  sm

let update sm dt = match sm with
  | StateMachine ( sts, t) ->
     List.iter (fun (s,t) ->
         match t with
         | Enter -> sts := s::!sts; s#enter sm
         | Leave -> s#leave sm; sts := List.tl !sts
       ) !t
    ;
    t := [];
    match !sts with
    | s::_ -> s#update dt; None
    | _ -> None

      

  





