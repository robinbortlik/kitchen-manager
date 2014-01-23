describe "Cart", ->
  cart = App.Cart.new

  it "calculate content", ->
    cart.set "content", [{id: 1, name: "Apple", price: "1"}, {id: 1, name: "Apple", price: "1"}]
    expect(cart.get("calculatedContent")).toEqual([{count: 2, name: "Apple", price: 2}])

