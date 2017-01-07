module CourseHelper

  def program_hash_tree tree
    array = ""
    tree.times do |n|
      array << "|_" if n != 0
    end
    array
  end
end
