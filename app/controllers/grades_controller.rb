class GradesController < ApplicationController
  def new
      @grade = Grade.new
    if logged_in_as_admin
      render :new_admin
    elsif logged_in_as_lecturer
      render :new_lecturer
    else
      kick_out
    end
  end

  def index
    if logged_in_as_admin
      @grades = Grade.all
      render :index_admin
    elsif logged_in_as_lecturer
      @grades = Grade.all
      render :index_lecturer
    elsif logged_in_as_student
      if params[:lecturer]
        @grades = Grade.joins(lecture: :lecturer).where("grades.student_id = #{current_user.id.to_s} AND users.login LIKE '%#{params[:lecturer]}%'")
      else
        @grades = Grade.where(:student_id => current_user.id)
      end
      render :index_student
    else
      kick_out
    end
  end

  def create
    if logged_in_as_admin
      @grade = Grade.new(params.require(:grade).permit(:student_id, :lecture_id, :grade, :comment))
      if @grade.save
        flash[:success] = "Grade created!"
        redirect_to grades_path
      else
        render :new_admin
      end
    elsif logged_in_as_lecturer
      # TODO: restrict more
      @grade = Grade.new(params.require(:grade).permit(:student_id, :lecture_id, :grade))
      if @grade.save
        flash[:success] = "Grade created!"
        redirect_to grades_path
      else
        render :new_lecturer
      end
    else
      kick_out
    end
  end
 
  def edit
    if logged_in_as_admin
      @grade = Grade.find(params[:id])
      render :edit_admin
    elsif logged_in_as_lecturer
      @grade = Grade.find(params[:id])
      if Lecturer.find(current_user.id).lectures.include? @grade.lecture 
        render :edit_lecturer
      else
        kick_out
      end
    elsif logged_in_as_student
      @grade = Grade.find(params[:id])
      if @grade.student != Student.find(current_user.id)
        kick_out
      else
        render :edit_student
      end
    else
      kick_out
    end
  end

  def update
    if logged_in_as_admin
      @grade = Grade.find(params[:id])
      if @grade.update(params.require(:grade).permit(:student_id, :lecture_id, :grade, :comment))
        flash[:success] = "Update successful!"
        redirect_to grades_path
      else
        render :edit_admin
      end
    elsif logged_in_as_lecturer
      @grade = Grade.find(params[:id])
      if @grade.update(params.require(:grade).permit(:grade))
        flash[:success] = "Update successful!"
        redirect_to grades_path
      else
        render :edit_lecturer
      end
    elsif logged_in_as_student
      @grade = Grade.find(params[:id])
      if @grade.student != Student.find(current_user.id)
        kick_out
      else
        if @grade.update(params.require(:grade).permit(:comment))
          flash[:success] = "Update successful!"
          redirect_to grades_path
        else
          render :edit_student
        end
      end
    else
      kick_out
    end
  end
end
