# frozen_string_literal: true

Rails.logger.debug 'Creating projects and tasks...'
User.all.find_each do |user|
  7.times do
    project = user.projects.create!(
      title: Faker::Company.catch_phrase,
      description: Faker::Lorem.paragraph,
      start_date: Faker::Date.backward(days: 14),
      end_date: Faker::Date.forward(days: 30),
      progress: Faker::Number.between(from: 0, to: 100),

      user_id: user.id
    )

    5.times do
      project.tasks.create!(
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.paragraph,
        status: %w[not_started in_progress completed].sample,
        due_date: Faker::Date.forward(days: 30),
        user:
      )
    end
  end
end
