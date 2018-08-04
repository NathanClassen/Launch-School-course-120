class Student

  def initialize name, grade
    @name = name
    @grade = grade
  end

  attr_accessor :name

  def better_grade_than? student
    grade > student.grade ? "Well done!" : "Not quite"
  end

  protected
  attr_accessor :grade
end

billy = Student.new "William", 97
bob   = Student.new "Robert", 109

puts billy.better_grade_than? bob