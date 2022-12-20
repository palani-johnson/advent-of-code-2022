module matrix

pub alias matrix<a> = list<list<a>>

pub fun transpose(matrix : matrix<a>) : <exn|e> matrix<a>
  matrix[0].unjust.map-indexed fn (index, _)
    matrix.map fn (row)
      row[index].unjust

pub fun rotate(matrix : matrix<a>) : <exn|e> matrix<a>
  matrix.transpose.map fn (row)
    row.reverse

pub fun or(a : matrix<bool>, b : matrix<bool>) : matrix<bool>
  a.zipwith(b) fn (line-a, line-b)
    line-a.zipwith(line-b) fn (val-a, val-b)
      val-a || val-b
