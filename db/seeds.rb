# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
# encoding: utf-8
Product.delete_all

seed_image = File.open('/Users/devankestel1/Documents/TheIronTome/app/assets/images/ruby.jpg')

seed_1 = Product.create!(title: 'CoffeeScript',
  description:
    %{<p>
        CoffeeScript is JavaScript done right. It provides all of JavaScript's
	functionality wrapped in a cleaner, more succinct syntax. In the first
	book on this exciting new language, CoffeeScript guru Trevor Burnham
	shows you how to hold onto all the power and flexibility of JavaScript
	while writing clearer, cleaner, and safer code.
      </p>},
  price: 36.00)

seed_1.image = seed_image
seed_1.save!
# . . .
seed_2 = Product.create!(title: 'Programming Ruby 1.9 & 2.0',
  description:
    %{<p>
        Ruby is the fastest growing and most exciting dynamic language
        out there. If you need to get working programs delivered fast,
        you should add Ruby to your toolbox.
      </p>},
  price: 49.95)
# . . .
seed_2.image = seed_image
seed_2.save!

seed_3 = Product.create!(title: 'Rails Test Prescriptions',
  description:
    %{<p>
        <em>Rails Test Prescriptions</em> is a comprehensive guide to testing
        Rails applications, covering Test-Driven Development from both a
        theoretical perspective (why to test) and from a practical perspective
        (how to test effectively). It covers the core Rails testing tools and
        procedures for Rails 2 and Rails 3, and introduces popular add-ons,
        including Cucumber, Shoulda, Machinist, Mocha, and Rcov.
      </p>},
  price: 34.95)

seed_3.image = seed_image
seed_3.save!

User.create()

require 'ffaker'

100.times do
  product_seed = Product.create!(
    title: FFaker::HipsterIpsum.phrase,
    description: FFaker::HipsterIpsum.paragraph,
    price: "#{rand(1..51)}.#{rand(1..100)}".to_f
  )
  product_seed.image = seed_image
  product_seed.save!
end
seed_image.close
