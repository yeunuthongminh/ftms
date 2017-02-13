namespace :run do
  desc "build npm"
  task npm: :environment do
    # sh -c "rm app/assets/webpack/* || true && cd client && npm run build:development"
  end
end
