begin
  require 'github_changelog_generator/task'
  require 'mixlib/install'

  namespace :changelog do
    # Fetch the latest version from mixlib-install
    latest_stable_version = Mixlib::Install.available_versions('inspec', 'stable').last

    # Run this to just update the changelog for the current release. This will
    # take what is in HISTORY and generate a changelog of PRs between the most
    # recent stable version and HEAD.
    GitHubChangelogGenerator::RakeTask.new :update do |config|
      config.future_release = "v#{Inspec::VERSION}"
      config.max_issues = 0
      config.add_issues_wo_labels = false
      config.add_pr_wo_labels = true
      config.enhancement_labels = ['enhancement', 'feature request']
      config.bug_labels = ['bug']
      config.exclude_labels = ['duplicate', 'question', 'invalid', 'wontfix', 'Exclude From Changelog']
    end
  end

  task :changelog => 'changelog:update'
rescue LoadError
  puts 'github_changelog_generator is not available.'
end
