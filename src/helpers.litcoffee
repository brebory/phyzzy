exports.zip = (A, B, fn) ->
  fn?(A[index], B[index]) || [A[index], B[index]] for _, index in A

exports.box = (n) ->
  [n]
