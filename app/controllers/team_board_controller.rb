class TeamBoardController < ApplicationController
  unloadable

  before_filter :find_project, :authorize, :find_versions, :only => :show

  def show
    @issue_status = IssueStatus.order(:position)
    @issue_status = @issue_status.where('id IN (?)', status_ids) if status_ids

    @assignees = @project.issues
                         .where('assigned_to_id IS NOT NULL')
                         .where(:fixed_version_id => current_version.id)
                         .includes(:assigned_to)
                         .order(:assigned_to_id)
    @assignees = @assignees.group_by{ |i| i.assigned_to_id }
  end

  private

    def find_project
      @project = Project.find(params[:project_id])
    end

    def find_versions
      @versions = @project.versions.open.order(:effective_date).reverse_order
    end

    def current_version
      return @current_version if @current_version

      if params.has_key?(:version_id)
        @current_version = @versions.where(:id => params[:version_id]).first
      else
        @current_version = @versions.where("effective_date >= ?", Time.now).first
      end
    end

    def status_ids
      if Setting.plugin_team_board['statuses'] == 'all'
        nil
      else
        Setting.plugin_team_board['statuses'].map(&:to_i)
      end
    end

end
