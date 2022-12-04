module sort

pub fun sort(xs : list<int>) : <div|_e> list<int>
  match xs
    Cons(x, xx) -> xx.filter(fn (y) y >= x).sort ++ [x] ++ xx.filter(fn (y) y < x).sort
    Nil        -> Nil
