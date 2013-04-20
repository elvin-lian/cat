Then(/^the comment of this product shout be created$/) do

  @product.product_comments.count.should eq 1

end