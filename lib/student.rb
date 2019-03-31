require_relative "../config/environment.rb"

class Student

attr_reader :id, :name, :grade
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  def initialize(id:, name:, grade:)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    DB[:conn].execute('CREATE TABLE students(id PRIMARY KEY, name TEXT, grade INTEGER)')
  end

  def self.drop_table
    DB[:conn].execute('DROP TABLE students')
  end

  def save
    DB[:conn].execute('INSERT INTO students (name, grade) VALUES (@name, @grade) ')
  end

  def create(name:, grade:)
    DB[:conn].execute('INSERT INTO students (name, grade) VALUES (?, ?)', :name, :grade)
  end

  def self.new_from_db(array)
    Student.new(array[0],array[1],array[2])
  end

  def self.find_by_name(name)
    student = DB[:conn].execute('SELECT * FROM students WHERE :name == name ')
    new_from_db(student)
  end

  def update
    DB[:conn].execute('UPDATE studemts SET name = ?, album = ? WHERE id = ?', @name, @grade, @id)
  end
end
