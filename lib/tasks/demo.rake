# frozen_string_literal: true

namespace :demo do
  desc 'Price every variant in EUR, switch shipping calculators to EUR, set stock to 1000'
  task eur_and_stock: :environment do
    Spree::Store.update_all(default_currency: 'EUR')

    Spree::Variant.includes(:prices).find_each do |variant|
      usd = variant.prices.find { |p| p.currency == 'USD' }
      next unless usd

      eur = variant.prices.find_or_initialize_by(currency: 'EUR', country_iso: nil)
      eur.update!(amount: usd.amount)
    end

    Spree::Calculator.find_each do |calculator|
      next unless calculator.respond_to?(:preferred_currency)

      calculator.update!(preferred_currency: 'EUR')
    end

    Spree::StockItem.update_all(count_on_hand: 1000)

    puts "variants: #{Spree::Variant.count}, EUR prices: #{Spree::Price.where(currency: 'EUR').count}, stock: 1000"
  end
end
