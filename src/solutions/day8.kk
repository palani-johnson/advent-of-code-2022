module day8

import src/lib


effect val forest : matrix<int>
effect val forest-vec : vector<vector<int>>
effect val forest-size : (int, int)
effect ctl move-around() : ()

fun look-around() : <forest> matrix<bool>
  forest.map fn (line)
    var highest := -1

    line.map fn (height)
      if height > highest then
        highest := height
        True
      else False

fun count-seen(seen : matrix<bool>)
  seen.map fn (line) { line.map(int).sum }.sum

fun look-at-all-them-trees()
  var seen-map := look-around()

  for(1, 3) fn (_)
    move-around()
    seen-map := seen-map.rotate.or(look-around())

  printm(seen-map.rotate)
  move-around()
  seen-map.rotate

fun printm(matrix : matrix<bool>)
  matrix.foreach fn (row) row
    .map fn (a) { if a then "*" else " " }
    .join
    .println

fun init-forest(a)
  with val forest = get-input("8").trim.lines.map fn (line)
    line.trim.list.map fn (c)
      c.int - '0'.int

  with ctl move-around()
    with override val forest = forest.rotate
    resume(())

  a()

/**
  I know effects/handlers aren't the best way to do this but i wanted
  to use them in some way
*/
pub fun main()
  // part 1
  with init-forest

  val seen-map = look-at-all-them-trees()
  println("Problem 1: " ++ seen-map.count-seen.show)

  // part 2
  with init-forest

  var max-score := -1
  val forest-vec = forest.map(vector).vector
  val (width, height) = (forest-vec.length, forest-vec[0].length)

  forest.foreach-indexed fn (i, row)
    row.foreach-indexed fn (j, _)
      val treehouse-height = forest-vec[i][j]

      val a = [
        list(0, i - 1).map fn (ii) { forest-vec[ii][j] }.reverse,  // up
        list(i + 1, width - 1).map fn (ii) { forest-vec[ii][j] },  // down
        list(0, j - 1).map fn (jj) { forest-vec[i][jj] }.reverse,  // left
        list(j + 1, height - 1).map fn (jj) { forest-vec[i][jj] }, // right
      ].map fn(line)
        var trees := 0
        line.foreach-while fn (tree)
          trees := trees + 1
          if tree >= treehouse-height return Just(trees)
          Nothing
        trees

      max-score := a
      .foldl(1) fn (acc, v) { acc * v }
      .max(max-score)

  println("Problem 2: " ++ max-score.show)

