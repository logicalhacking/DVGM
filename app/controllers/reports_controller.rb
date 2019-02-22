class ReportsController < ApplicationController
  @@report_dir = Rails.root.join("public", "reports")

  def create
    if logged_in_as_student
      user = current_user
      filename = user.id.to_s + ".pdf"
      report = GradeReport.new(user, Grade.where(:student => user))
      report.render_file @@report_dir.join(filename)

      redirect_to action: 'show', filename: filename
    else
      kick_out
    end
  end
end
