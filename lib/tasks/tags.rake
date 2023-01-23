namespace :tags do
  desc "Seeds tags"
  task seed_tags: :environment do
    Tag.create!([{
                   name: "General"
                 },
                 {
                  name: "Bug fix"
                 },
                 {
                   name: "Configuration"
                 },
                 {
                   name: "Testing"
                 },
                 {
                   name: "Machine Learning"
                 },
                 {
                   name: "Efficiency"
                 }])

    p "Created #{Tag.count} tags"
  end
end