open Ecs
open Component
open Entity

class position () =
  let r = init Vector.zero in
  object
    method position = r
  end

class box () =
  let r = init Rect.{width = 0; height = 0} in
  object
    method box = r
  end

class texture () =
  let r = init (Texture.Color (Gfx.color 0 0 0 255)) in
  object
    method texture = r
  end

class velocity () =
  let r = init Vector.zero in
  object
    method velocity = r
  end

            
              

class type drawable =
  object
    inherit Entity.t
    inherit position
    inherit box
    inherit texture
  end

class type movable =
  object
    inherit Entity.t
    inherit position
    inherit velocity
  end

          

class character =
  object
    inherit Entity.t ()
    inherit position ()
    inherit velocity ()
    inherit box ()
    inherit texture ()
  end
