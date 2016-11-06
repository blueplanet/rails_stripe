# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Plan.create(
  id: 1,
  stripe_plan_id: 'year',
  name: '年払い',
  currency: :jpy,
  interval: 'year',
  amount: 10_000
)

Plan.create(
  id: 2,
  stripe_plan_id: 'month',
  name: '月払い',
  currency: :jpy,
  interval: 'month',
  amount: 1_000
)

Plan.find_each do |plan|
  Stripe::Plan.create(
    id: plan.stripe_plan_id,
    amount: plan.amount,
    currency: plan.currency,
    interval: plan.interval,
    name: plan.name
  )
end
