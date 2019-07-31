def consolidate_cart(cart)
  cc = {}
  cart.each do |item|
    if cc[item.keys[0]]
      cc[item.keys[0]] [:count] += 1
    else
      cc[item.keys[0]] = {
        price: item.values[0][:price],
        clearance: item.values[0][:clearance],
        count: 1
      }
    end
  end
  cc
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        savings = "#{coupon[:item]} W/COUPON"
        if cart[savings]
          cart[savings][:count] += coupon[:num]
        else
          cart[savings] = {
            count: coupon[:num],
            price: coupon[:cost]/coupon[:num],
            clearance: cart[coupon[:item]][:clearance]
          }
        end
        cart[coupon[:item]][:count] -= coupon[:num]
    end
  end
end
  cart
end

def apply_clearance(cart)
  cart.keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price] - (cart[item][:price]*0.2).round(2))
    end
  end
  cart
end

def checkout(cart, coupons)
  cc = consolidate_cart(cart)
  couponed = apply_coupons(cc, coupons)
  discounted = apply_clearance(couponed)
  
end
