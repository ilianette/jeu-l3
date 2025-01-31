open Global
open State_machine

type inp = JustPressed | JustReleased | Pressed



let key_table = Hashtbl.create 16
let has_key s = Hashtbl.mem key_table s
let set_key s = if has_key s then Hashtbl.replace key_table s Pressed else Hashtbl.replace key_table s JustPressed
let unset_key s = Hashtbl.find_opt key_table s |> Option.iter (function | JustPressed | Pressed -> Hashtbl.replace key_table s JustReleased | JustReleased -> Hashtbl.remove key_table s)

let just_pressed s = match Hashtbl.find_opt key_table s with
  | Some JustPressed -> true
  | _ -> false

let just_released s = match Hashtbl.find_opt key_table s with
  | Some JustReleased -> true
  | _ -> false


let action_table = Hashtbl.create 16
let on_press_table = Hashtbl.create 16
let on_release_table = Hashtbl.create 16

let _connect table (key: string) (action: unit -> unit) = Hashtbl.replace table key action

let connect = _connect action_table
let connect_on_press = _connect on_press_table
let connect_on_release = _connect on_release_table

let disconnect key = Hashtbl.remove action_table key; Hashtbl.remove on_press_table key; Hashtbl.remove on_release_table key


let handle_input () =
  let () =
    let events = Gfx.poll_event () in
    while not (Queue.is_empty events) do
      match Queue.take events with
        KeyDown s -> set_key s
      | KeyUp s ->  unset_key s
      | Quit -> clear (get ()).sm ; exit 0
      | _ -> ()
    done
  in
    Hashtbl.iter (fun key action ->
        if just_pressed key then (action (); set_key key)) on_press_table;
    Hashtbl.iter (fun key action ->
        if just_released key then (action (); unset_key key)) on_release_table;
    Hashtbl.iter (fun key action ->
      if has_key key then action ()) action_table

  
    

 
