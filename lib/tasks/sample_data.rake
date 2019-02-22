namespace :db do
  desc "Populate database with default data"
  def generate_report(user)
    FileUtils.mkdir_p(Rails.configuration.report_dir) unless File.directory?(Rails.configuration.report_dir)
    filename = user.id.to_s + ".pdf"
    report = GradeReport.new(user, Grade.where(:student => user))
    report.render_file Rails.configuration.report_dir.join(filename)
  end

  def generate_password(password)
    return Digest::MD5.hexdigest(password)
  end

  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    u1 = User.create!(:login => "peter", :role => "student", :password => generate_password("football"))
    u2 = User.create!(:login => "alice", :role => "student", :password => generate_password("wonderland3"))
    u3 = User.create!(:login => "stacy", :role => "student", :password => generate_password("ijv88234ji"))
    u4 = User.create!(:login => "ben", :role => "student", :password => generate_password("passw0rd"))
    u5 = User.create!(:login => "kim", :role => "student", :password => generate_password("12321"))
    u6 = User.create!(:login => "jack", :role => "student", :password => generate_password("s3cret"))
    u7 = User.create!(:login => "kate", :role => "student", :password => generate_password("geheim!"))
    u8 = User.create!(:login => "sophie", :role => "student", :password => generate_password("flowerpot"))

    l1 = User.create!(:login => "achim", :role => "lecturer", :password => generate_password("dvgmisinsecure"),
                     :secret_question => "From the university in which city did I get my Master's degree?",
                     :secret_answer => "Freiburg")
    l2 = User.create!(:login => "greg", :role => "lecturer", :password => generate_password("supersecure321"))
    l3 = User.create!(:login => "david", :role => "lecturer", :password => generate_password("david3"))
    l4 = User.create!(:login => "john", :role => "lecturer", :password => generate_password("johnjohnson"))

    lec1 = Lecture.create(:name => "Security", :lecturer_id => l1.id)
    lec2 = Lecture.create(:name => "Algorithms", :lecturer_id => l2.id)
    lec3 = Lecture.create(:name => "Java Programming", :lecturer_id => l3.id)
    lec4 = Lecture.create(:name => "Algebra", :lecturer_id => l4.id)
    lec5 = Lecture.create(:name => "Probability Theory", :lecturer_id => l2.id)
    lec6 = Lecture.create(:name => "Software Hut", :lecturer_id => l1.id)

    Grade.create(:lecture_id => lec1.id, :student_id => u1.id, :grade => 45, :comment => "Seems like I should have studied more...")
    Grade.create(:lecture_id => lec2.id, :student_id => u1.id, :grade => 90, :comment => "Sweet! All that studying paid off!")
    Grade.create(:lecture_id => lec5.id, :student_id => u1.id, :grade => 30, :comment => "I thought this is computer science!?")
    Grade.create(:lecture_id => lec4.id, :student_id => u2.id, :grade => 80)
    Grade.create(:lecture_id => lec5.id, :student_id => u2.id, :grade => 73)
    Grade.create(:lecture_id => lec1.id, :student_id => u2.id, :grade => 44)
    Grade.create(:lecture_id => lec3.id, :student_id => u3.id, :grade => 59, :comment => "Could you bump me to a 60 at least, please?")
    Grade.create(:lecture_id => lec5.id, :student_id => u3.id, :grade => 47)
    Grade.create(:lecture_id => lec2.id, :student_id => u4.id, :grade => 83)
    Grade.create(:lecture_id => lec3.id, :student_id => u4.id, :grade => 66)
    Grade.create(:lecture_id => lec5.id, :student_id => u4.id, :grade => 73)
    Grade.create(:lecture_id => lec6.id, :student_id => u4.id, :grade => 63)
    Grade.create(:lecture_id => lec6.id, :student_id => u4.id, :grade => 23, :comment => "We did not have enough time in the final!")
    Grade.create(:lecture_id => lec1.id, :student_id => u5.id, :grade => 0, :comment => "The upload was broken!")
    Grade.create(:lecture_id => lec3.id, :student_id => u5.id, :grade => 94, :comment => "Nice!")
    Grade.create(:lecture_id => lec5.id, :student_id => u5.id, :grade => 66)
    Grade.create(:lecture_id => lec6.id, :student_id => u5.id, :grade => 7, :comment => "Oh boy...")

    generate_report(u1)
    generate_report(u2)
    generate_report(u3)
    generate_report(u4)
    generate_report(u5)
    generate_report(u6)
    generate_report(u7)
    generate_report(u8)
  end
end
