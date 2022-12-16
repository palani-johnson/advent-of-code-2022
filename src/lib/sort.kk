module sort

pub fun sort(xs : list<int>) : <div|_e> list<int>
  match xs
    Cons(x, xx) ->
      val (start, end) = xx.partition fn (y) y >= x
      start.sort ++ [x] ++ end.sort
    Nil -> Nil
