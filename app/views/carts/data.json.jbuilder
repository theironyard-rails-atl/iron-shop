json.items @cart.items, :id, :title, :description, :price, :seller_id
json.subtotal @cart.subtotal
json.tax_rate @cart.tax_rate
json.total @cart.total

