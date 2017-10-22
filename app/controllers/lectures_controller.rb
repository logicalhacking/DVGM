class LecturesController < ApplicationController
  def new
    if logged_in_as_admin
      @lecture = Lecture.new
      render :new_admin
    elsif logged_in_as_lecturer
      @lecture = Lecture.new
      render :new_lecturer
    else
      kick_out
    end
  end

  def index
    if logged_in_as_admin or logged_in_as_lecturer
      @lectures = Lecture.all
    else
      kick_out
    end
  end

  def create
    if logged_in_as_admin
      @lecture = Lecture.new(params.require(:lecture).permit(:name, :lecturer_id))
      if @lecture.save
        flash[:success] = "Lecture created!"
        redirect_to lectures_path
      else
        render :new_admin
      end
    elsif logged_in_as_lecturer
      @lecture = Lecture.new(params.require(:lecture).permit(:name))
      @lecture.lecturer = Lecturer.find(current_user.id)
      if @lecture.save
        flash[:success] = "Lecture created!"
        redirect_to lectures_path
      else
        render :new_admin
      end
    else
      kick_out
    end
  end
end
