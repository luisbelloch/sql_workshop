require 'csv'
require 'set'
require 'faker'
require 'spicy-proton'

PORTAL_COUNT = 10_000
TAG_COUNT = 2_000
MATRIX_COUNT = 100_000

def portal(n)
  n.times.each do |i|
    puts [i, Spicy::Proton.adjective.capitalize + " " + Faker::Company.name, rand(0..MATRIX_COUNT)].to_csv
  end
end

def tag(n)
  n.times.map { |i| Spicy::Proton.verb }.to_set.each do |tag|
    puts tag
  end
end

def currencies
  @currencies ||= CSV.read('currency.tsv', col_sep: "\t").to_h
end

def matrix(n)
  (0..n).step(4).each do |i|
    currency_code = currencies.keys.sample
    puts [i, Spicy::Proton.adjective.capitalize + " " + Faker::Commerce.product_name, currency_code].to_csv
    puts [i+1, Spicy::Proton.adjective.capitalize + " " + Faker::Movie.title, currency_code].to_csv
    puts [i+2, Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 4), currency_code].to_csv
    puts [i+3, Spicy::Proton.adjective.capitalize + " " + Faker::Book.title, currency_code].to_csv
  end
end

portal(PORTAL_COUNT) if ARGV[0] =~ /portal/
tag(TAG_COUNT) if ARGV[0] =~ /tag/
matrix(MATRIX_COUNT) if ARGV[0] =~ /matrix/
