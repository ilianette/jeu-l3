open Components

type t = movable

let init _ = ()

let update dt el =
  Seq.iter (fun (e:t) ->
      let vel = e#velocity#get in
      print_float vel.x; print_newline ();
      e#position#set (Vector.add e#position#get (Vector.mult (dt /. 60.) vel));
    ) el

