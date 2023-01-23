namespace :languages do
  desc "Seeds languages"
  task seed_languages: :environment do
    Language.create!([{
                        name: "PHP"
                      },
                      {
                        name: "Java"
                      },
                      {
                        name: "Python"
                      },
                      {
                        name: "JavaScript"
                      },
                      {
                        name: "C/C++"
                      },
                      {
                        name: "Typescript"
                      },
                      {
                        name: "HTML"
                      },
                      {
                        name: "CSS"
                      },
                      {
                        name: "Ruby"
                      },
                      {
                        name: "yaml"
                      },
                      {
                        name: "Plain text"
                      }
                     ])

    p "Created #{Language.count} languages"
  end
end