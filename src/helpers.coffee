# Helpers
# =======
#
# Useful helper and utility functions to support a more fuctional programming style.
#
# ## Zip ##
# `zip` combines the elements of two lists into a single list using an optional mapping callback.
# * @param `A`    - The first array to zip
# * @param `B`    - The second array to zip
# * @param `[fn]` - A function to use to zip arrays together. Optional. If invoked without the `fn` argument, will default to zipping `A` and `B` to a list of tuples by position.
# * @return       - A result list from `A` and `B` using `fn` as a mapping callback.

exports.zip = (A, B, fn) ->
  fn?(A[index], B[index]) || [A[index], B[index]] for _, index in A

# ## Box ##
# `box` transforms a singleton element into a list.
# * @param `n` - The singleton element to return as a list.
# * @return    - A list containing the singleton element passed to `box`.

exports.box = (n) ->
  [n]
