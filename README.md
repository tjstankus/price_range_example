Price range presenter spike
===========================

A quick demo of wrapping a simple `PriceRange` model in a presentation object.
All presentation logic is kept in the `PriceRangePresenter`.

I would argue that given a choice between the [first commit](http://git.io/F4qV)
and the [second commit](http://git.io/F4qy), the first commit is simpler,
despite the fact that the second commit removes the conditional and is
open/closed. We introduce a fair amount of code to enable the removal of a
simple, isolated conditional. If there were more types of price ranges, or if
the presentation logic grew in complexity, the approach of the second commit
might be warranted.
