class ReportsController < ApplicationController
  def create
    if logged_in_as_student
      user = current_user
      filename = user.id.to_s + ".pdf"
      report = GradeReport.new(user, Grade.where(:student => user))
      FileUtils.mkdir_p(Rails.configuration.report_dir) unless File.directory?(Rails.configuration.report_dir)
      report.render_file Rails.configuration.report_dir.join(filename)

      redirect_to "/reports/" + filename
    else
      kick_out
    end
  end
end
