open Ecs

class position () =
  let r = Component.init Vector.zero in
  object
    method position = r
  end
