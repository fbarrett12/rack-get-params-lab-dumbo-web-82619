class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/add/)
      searched_item = req.params["item"]
      if @@items.include?(searched_item) && @@cart.include?(searched_item)
        resp.write "Item already in cart"
        elsif !@@items.include?(searched_item)
          resp.write "We don't have that item"
          else
            @@cart << searched_item
            resp.write "added #{searched_item}"
          end




    elsif req.path.match(/cart/)
      if @@cart == []
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
        resp.write "#{item}\n"
        end
      end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

end
