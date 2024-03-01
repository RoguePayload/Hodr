# lib/tasks/scheduler.rake
namespace :metrics do
  desc "Capture Heroku metrics"
  task capture_heroku_metrics: :environment do
    # Heroku CLI command to fetch recent logs including metrics
    logs = `heroku logs --app beta-hodr --num 1500`

    # Example of parsing a memory usage log entry
    memory_usage = logs.scan(/sample#memory_total=\d+\.\d+MB/).last
    if memory_usage
      memory_value = memory_usage.match(/\d+\.\d+/)[0].to_f
      # Save the parsed metric to the database
      Metric.create!(name: 'memory_usage', value: memory_value, captured_at: Time.current)
    end

    # Repeat for other metrics you're interested in
  end
end
