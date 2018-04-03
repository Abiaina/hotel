What classes does each implementation include? Are the lists the same?
  Both A & B have classes: CartEntry, ShoppingCart, and Order. Yes, the list of classes are the same for both implementations.

Write down a sentence to describe each class.
  CartEntry: Tracks the quantity of each item ordered and their individual item costs. B has a method to calculate cost of items.

  ShoppingCart: Tracks the items ordered, can calculate the subtotal or order. B has a method to calculate running subtotal.

  Order: Calculates the total for each order, B does relies on its other classes and their methods to do the logic required.

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
  Order class creates a shopping cart that has an instance variable entries that can store instances of Cart entries. This is then used to calculate total price with the order class' total_price instance method.


What data does each class store? How (if at all) does this differ between the two implementations?
  CartEntry: stores number quantity of an item and item unit price. Implementation B also has a method to return the price accounting only for item quantity.

  ShoppingCart: Stores instance of CartEntry. Implementation B calculates subtotal of all items in a cart.

  Order: creates instances of ShoppingCart and calculates the total_price of all items. ShoppingCart is an array that can hold instances of CartEntry.


What methods does each class have? How (if at all) does this differ between the two implementations?
  CartEntry & ShoppingCart Implementation A: no instance methods, except for initialize.

  CartEntry & ShoppingCart Implementation B: has 2 helper methods to calculate subtotal of instance variables values.

  Order Implementation A & B: Stores instance of CartEntry. Implementation B calculates subtotal of all items in a cart.

Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
  Implementation A: It is computed in Order.

  Implementation B: It is completed in all the classes. Total base price per item in CartEntry. Subtotal for all entries in ShoppingCart is called in ShoppingCart. Order does the final calculates the total or the order.

Does total_price directly manipulate the instance variables of other classes?
If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
  Implementation A: Yes it acts on the CartEntry class using instance variables unit_price and quantity.

  Implementation B: Yes it acts directly on the ShoppingCart instance using the price instance method of the ShoppingCart class.

Which implementation better adheres to the single responsibility principle?
    Implementation B because it only calculates the total price based on the subtotal returned by the ShoppingCart price instance method and shares the logic required for calculating the total across all of the classes.

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

  Implementation B because it separates uses a local variable subtotal and instance variable #@cart to shield the ShoppingCart instance from the calculation done by total_price method of Order.


Revisiting Hotel Activity
  There are a couple of places where I violate the single responsibility rule for classes.

  I chose to remove the instance variable price in admin and use a local variable to store the block room prices. This did not require any changes to my testing.
