Redmine::Plugin.register :team_board do
  name 'Team Board'
  author 'Moritz Lawitschka'
  description 'Scrum-like dashboard for getting a quick overview of what your team is working on.'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://lawitschka.me'

  # Permission definition
  project_module :team_board do
    permission :team_board, :team_board => :show
  end

  # Add link to project navigation bar
  menu :project_menu, :team_board,
                      { :controller => 'team_board', :action => 'show' },
                      :caption => 'Team Board',
                      :after => :activity,
                      :param => :project_id

  # Configuration options
  settings :default => {'statuses' => 'all'},
           :partial => 'settings/team_board_settings'
end
