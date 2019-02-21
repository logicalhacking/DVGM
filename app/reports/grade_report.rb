class GradeReport < Prawn::Document
  def initialize(user, grades=[])
    super()

    text "Grade Report for #{user.login}", size: 14, style: :bold_italic, align: :center

    table [["Lecture", "Grade"]] + grades.map { |g| [g.lecture.name.to_s, g.grade.to_s] },
      :row_colors => ["FFFFFF","DDDDDD"],
      :header => true,
      :column_widths => [100, 100],
      :position => :center do
        row(0).font_style = :bold
      end
  end
end
